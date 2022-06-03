"""
The definition of supported design parameters
[Taken from AutoDSE source code: https://github.com/UCLA-VAST/AutoDSE]
"""
import ast
from typing import Dict, List, Optional, Tuple, Type, Union, Set
# from saver import saver


class DesignParameter(object):
    """A tunable design parameter"""

    def __init__(self, name: str = ''):
        self.name: str = name
        self.default: Union[str, int] = 1
        self.option_expr: str = ''
        self.scope: List[str] = []
        self.order: Dict[str, str] = {}
        self.deps: List[str] = []
        self.child: List[str] = []
        self.value: Union[str, int] = 1


DesignSpace = Dict[str, DesignParameter]
DesignPoint = Dict[str, Union[int, str]]


def gen_key_from_design_point(point: DesignPoint) -> str:
    """Generate a unique key from the given design point.

    Args:
        point: The given design point.

    Returns:
        The generated key in the format of "param1-value1.param2-value2".
    """

    return '.'.join([
        '{0}-{1}'.format(pid,
                         str(point[pid]) if point[pid] else 'NA') for pid in sorted(point.keys())
    ])


def check_option_syntax(option_expr: str, log) -> Tuple[bool, List[str]]:
    """Check the syntax of design options and extract dependent design parameter IDs.

        Args:
            option_expr: The design space option expression.

        Returns:
            Indicate if the expression is valid or not; A list of dependent design parameter IDs.
    """

    try:
        stree = ast.parse(option_expr)
    except SyntaxError:
        log.error((f'"options" error: Illegal option list {option_expr}'))
        return (False, [])

    # Traverse AST of the option_expression for all variables
    names = set()
    iter_val = None
    for node in ast.walk(stree):
        if isinstance(node, ast.ListComp):
            funcs = [
                n.func.id for n in ast.walk(node.elt)
                if isinstance(n, ast.Call) and isinstance(n.func, ast.Name)
            ]
            elt_vals = [
                n.id for n in ast.walk(node.elt)
                if isinstance(n, ast.Name) and n.id not in funcs and n.id != '_'
            ]
            assert len(elt_vals) <= 1, 'Found more than one iterators in {0}'.format(option_expr)
            if len(elt_vals) == 1:
                iter_val = elt_vals[0]
        elif isinstance(node, ast.Name):
            names.add(node.id)

    # Ignore the list comprehension iterator
    if iter_val:
        names.remove(iter_val)

    # # Ignore legal builtin functions
    # for func in SAFE_LIST:
    #     if func in names:
    #         names.remove(func)

    # Ignore builtin primitive type casting
    for ptype in ['int', 'str', 'float']:
        if ptype in names:
            names.remove(ptype)

    return (True, list(names))


def check_order_syntax(order_expr: str, log) -> Tuple[bool, str]:
    """Check the syntax of the partition rule and extract the variable name.

    Args:
        order_expr: The design space option expression.

    Returns:
        Indicate if the expression is valid or not; The single variable name in the expression.
    """
    try:
        stree = ast.parse(order_expr)
    except SyntaxError:
        log.error((f'"order" error: Illegal order expression {order_expr}'))
        return (False, '')

    # Traverse AST of the expression for the variable
    names = set()
    for node in ast.walk(stree):
        if isinstance(node, ast.Name):
            names.add(node.id)

    if len(names) != 1:
        log.error((f'"order" should have one and only one variable in {order_expr} but found {len(names)}'))
        return (False, '')
    return (True, names.pop())


def create_design_parameter(param_id: str, ds_config: Dict[str, Union[str, int]],
                            param_cls: Type[DesignParameter],
                            log) -> Optional[DesignParameter]:
    """Create DesignParameter from the string.

    Args:
        param_id: The unique parameter ID.
        attr_str: The design space string in the auto pragma.
        param_cls: The class of parameter we will create.

    Returns:
        The created DesignParameter object.
    """

    if param_cls == DesignParameter:
        param = DesignParameter(param_id)

        # Type checking
        if 'ds_type' not in ds_config:
            log.warning((
                f'Missing attribute "ds_type" in {param_id}. Some optimization may not be triggered'))
        else:
            param.ds_type = str(ds_config['ds_type']).upper()
    else:
        log.error('Unrecognized parameter type')
        return None

    # General settings for parameters
    # Option checking
    if 'options' not in ds_config:
        log.error('Missing attribute "options" in %s', param_id)
        return None
    if 'TIL-' in param.ds_type:
        param.option_expr = str([1])   ###### pruning DS: removing the options on tile
    else:
        param.option_expr = str(ds_config['options'])
    check, param.deps = check_option_syntax(param.option_expr, log)
    if not check:
        return None

    # Partition checking
    if 'order' in ds_config:
        check, var = check_order_syntax(str(ds_config['order']), log)
        if not check:
            log.warning((f'Failed to parse "order" of {param_id}, ignore.'))
        else:
            param.order = {'expr': str(ds_config['order']), 'var': var}

    # Default checking
    if 'default' not in ds_config:
        log.error((f'Missing attribute "default" in {param_id}'))
        return None
    param.default = ds_config['default']

    return param


def get_default_point(ds: DesignSpace) -> DesignPoint:
    """Generate a design point with all default values.

    Returns:
        The design point with all default value applied.
    """

    point: DesignPoint = {}
    for pid, param in ds.items():
        point[pid] = param.default
    return point


def check_design_space(params: DesignSpace, log) -> int:
    """Check design space for missing dependency and duplication.

    Args:
        params: The overall design space.

    Returns:
        The number of errors found in the design space.
    """

    error = 0

    for pid, param in params.items():
        has_error = False

        # Check dependencies
        for dep in param.deps:
            if dep == pid:
                log.error((f'Parameter {pid} cannot depend on itself'))
                error += 1
                has_error = True
            if dep not in params.keys():
                log.error((f'Parameter {pid} depends on {dep} which is undefined or not allowed'))
                error += 1
                has_error = True

        if has_error:
            continue

        # Check expression types
        # Assign default value to dependent parameters
        local = {}
        for dep in param.deps:
            local[dep] = params[dep].default

        # Try to get an option list
        options: Optional[List[Union[int, str]]] = None
        try:
            options = eval(param.option_expr, local)
        except (NameError, ValueError, TypeError, ZeroDivisionError) as err:
            log.error('Failed to get the options of parameter %s: %s', pid, str(err))
            error += 1

        # Try to get the order of options
        if options is not None and param.order and isinstance(param, DesignParameter):
            for option in options:
                if eval(param.order['expr'], {param.order['var']: option}) is None:
                    log.error('Failed to evaluate the order of option %s in parameter %s', option,
                              pid)
                    error += 1
    return error


def analyze_child_in_design_space(params: DesignSpace) -> None:
    """Traverse design parameter dependency and build child list for each parameter in place.

    Args:
        params: The overall design space
    """

    # Setup child for each parameter
    for pid, param in params.items():
        for dep in param.deps:
            params[dep].child.append(pid)

    # Remove duplications
    for param in params.values():
        param.child = list(dict.fromkeys(param.child))
        
        
def topo_sort_param_ids(space: DesignSpace) -> List[str]:
    """Sort the parameter IDs topologically.

    Args:
        space: The design space to be sorted.

    Returns:
        The sorted IDs.
    """

    def helper(curr_id: str, visited: Set[str], stack: List[str]) -> None:
        """The helper function for topological sort."""
        visited.add(curr_id)
        for dep in space[curr_id].deps:
            if dep not in visited:
                helper(dep, visited, stack)
        stack.append(curr_id)
        # saver.info((f'added, {curr_id}'))

    visited: Set[str] = set()
    stack: List[str] = []
    for pid in space.keys():
        # saver.info(pid)
        if pid not in visited:
            helper(pid, visited, stack)
    return stack

def count_design_points(ds: DesignSpace, log) -> int:
    """Count the valid points in a given design space.

    Args:
        ds: Design space to be counted.

    Returns:
        Number of valid design points.
    """

    def helper(ds: DesignSpace, sorted_ids: List[str], idx: int, point: DesignPoint) -> int:
        """Count the deisgn points of parameters by traversing topological sorted parameters."""

        # Reach to the end
        if idx == len(sorted_ids):
            return 1

        pid = sorted_ids[idx]
        param = ds[pid]
        options = eval(param.option_expr, point)

        counter = 0
        if param.child:
            # Sum all points under each option
            for option in options:
                point[pid] = option
                counter += helper(ds, sorted_ids, idx + 1, point)
        else:
            # Product the number of options with the rest points
            counter = len(options) * helper(ds, sorted_ids, idx + 1, point)
        log.debug((f'Node {pid}: {counter}'))
        return counter

    point = get_default_point(ds)
    sorted_ids = topo_sort_param_ids(ds)
    return helper(ds, sorted_ids, 0, point)
        

def compile_design_space(user_ds_config: Dict[str, Dict[str, Union[str, int]]],
                         scope_map: Optional[Dict[str, List[str]]],
                         log) -> Optional[DesignSpace]:
    """Compile the design space from the config JSON file.

    Args:
        user_ds_config: The input design space configure loaded from a JSON file.
                        Note that the duplicated ID checking should be done when
                        loading the JSON file and here we assume no duplications.
        scope_map: The scope map that maps design parameter ID to its scope.

    Returns:
        The design space compiled from the kernel code; or None if failed.
    """
    params: Dict[str, DesignParameter] = {}
    for param_id, param_config in user_ds_config.items():
        param = create_design_parameter(param_id, param_config, DesignParameter, log)
        if param:               
            if param.ds_type not in [
                    'PARALLEL', 'PIPELINE', 'TILING', 'TILE'
            ]:
                param.scope.append('GLOBAL')
            else:
                if scope_map and param_id in scope_map:
                    param.scope = scope_map[param_id]
            params[param_id] = param

    error = check_design_space(params, log)
    if error > 0:
        log.error((f'Design space has {error} errors'))
        return None

    analyze_child_in_design_space(params)

    num_ds = count_design_points(params, log)
    log.info((f'Design space contains {num_ds} valid design points'))
    log.info('Finished design space compilation')
    return params, num_ds



