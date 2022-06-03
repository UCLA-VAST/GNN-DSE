"""
DSE config settings
[Taken from AutoDSE source code: https://github.com/UCLA-VAST/AutoDSE]
"""
from typing import Any, Dict, Optional


# All configurable attributes. Please follow the following rules if you want to add new config.
# 1) Follow the naming: <main-category>.<attribute>.<sub-attribute>
# 2) 'require' is necessary for every config.
# 3) If the config is optional ('require' is False), then 'default' is necessary.
# 4) If the config is limited to certain options, add 'options' to the config attribute.
CONFIG_SETTING: Dict[str, Dict[str, Any]] = {
    'project.name': {
        'require': False,
        'default': 'project'
    },
    'project.backup': {
        'require': False,
        'default': 'NO_BACKUP',
        'options': ['NO_BACKUP', 'BACKUP_ERROR', 'BACKUP_ALL']
    },
    'project.fast-output-num': {
        'require': False,
        'default': 4
    },
    'design-space.definition': {
        'require': True
    },
    'design-space.max-part-num': {
        'require': False,
        'default': 4
    },
    'evaluate.worker-per-part': {
        'require': False,
        'default': 2
    },
    'evaluate.command.transform': {
        'require': True,
    },
    'evaluate.command.hls': {
        'require': True,
    },
    'evaluate.max-util.BRAM': {
        'require': False,
        'default': 0.8
    },
    'evaluate.max-util.DSP': {
        'require': False,
        'default': 0.8
    },
    'evaluate.max-util.LUT': {
        'require': False,
        'default': 0.8
    },
    'evaluate.max-util.FF': {
        'require': False,
        'default': 0.8
    },
    'evaluate.command.bitgen': {
        'require': True,
    },
    'search.algorithm.name': {
        'require': False,
        'default': 'gradient',
        'options': ['exhaustive', 'gradient', 'hybrid']
    },
    'search.algorithm.exhaustive.batch-size': {
        'require': False,
        'default': 2
    },
    'search.algorithm.gradient.latency-threshold': {
        'require': False,
        'default': 64
    },
    'search.algorithm.gradient.fine-grained-first': {
        'require': False,
        'default': True
    },
    'search.algorithm.gradient.quality-type': {
        'require': False,
        'default': 'performance',
        'options': ['finite-difference', 'performance', 'resource-efficiency']
    },
    'search.algorithm.gradient.compute-bound-order': {
        'require': False,
        'default': ['PARALLEL', 'PIPELINE']
    },
    'search.algorithm.gradient.memory-bound-order': {
        'require': False,
        'default': ['INTERFACE', 'CACHE', 'PIPELINE', 'TILE', 'TILING']
    },
    'timeout.exploration': {
        'require': True,
    },
    'timeout.transform': {
        'require': True,
    },
    'timeout.hls': {
        'require': True,
    },
    'timeout.bitgen': {
        'require': True,
    }
}


def build_config(user_config: Dict[str, Any], log) -> Optional[Dict[str, Any]]:
    """Check user config and apply default value to optional configs.

    Args:
        user_config: The user config to be referred.

    Returns:
        A nested dict of configs, or None if there has any errors.
    """


    # Check user config and make up optional values
    error = 0
    for key, attr in CONFIG_SETTING.items():
        if key in user_config:
            if 'options' in attr:
                # Specified config, check if it is legal
                if user_config[key] not in attr['options']:
                    log.error((f'"{user_config[key]}" is not a valid option for {key}'))
                    error += 1
        else:
            # Missing config, check if it is optional (set to default if so)
            if attr['require']:
                log.error((f'Missing "{key}" in the config which is required'))
                error += 1
            else:
                d = attr['default']
                log.info((f'Use default value for {key}: {str(d)}'))
                user_config[key] = d

    for key in user_config.keys():
        if key not in CONFIG_SETTING:
            log.error((f'Unrecognized config key: {key}'))
            error += 1

    if error > 0:
        return None

    # Build config
    config: Dict[str, Any] = {}
    for key, attr in user_config.items():
        curr = config
        levels = key.split('.')
        for level in levels[:-1]:
            if level not in curr:
                curr[level] = {}
            curr = curr[level]
        curr[levels[-1]] = attr

    return config
