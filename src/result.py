"""
[Taken from AutoDSE source code: https://github.com/UCLA-VAST/AutoDSE]
"""
from parameter import DesignPoint

from enum import Enum
from typing import Dict, Optional


class Result(object):
    """The base module of evaluation result"""

    class RetCode(Enum):
        PASS = 0
        UNAVAILABLE = -1
        EARLY_REJECT = -2
        DUPLICATED = -3

    def __init__(self, ret_code_str: str = 'PASS'):

        # The design point of this result.
        self.point: Optional[DesignPoint] = None

        # The return code of the evaluation
        self.ret_code: Result.RetCode = self.RetCode[ret_code_str]

        # Indicate if this result is valid to be a final output. For example, a result that
        # out-of-resource is invalid.
        self.valid: bool = False

        # The quantified QoR value. Larger the better.
        self.quality: float = -float('inf')

        # Performance in terms of estimated cycle or log of the estimated cycle.
        self.perf: float = 0.0
        
        # Performance in terms of estimated cycle or onboard runtime.
        self.actual_perf: float = 0.0

        # Resource utilizations
        self.res_util: Dict[str, float] = {
            'util-BRAM': 0,
            'util-DSP': 0,
            'util-LUT': 0,
            'util-FF': 0,
            'total-BRAM': 0,
            'total-DSP': 0,
            'total-LUT': 0,
            'total-FF': 0
        }

        # Elapsed time for evaluation
        self.eval_time: float = 0.0