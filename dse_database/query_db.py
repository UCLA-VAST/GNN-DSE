######################################################################################
### sample file for reading the database info and query the required information   ###
### here, it writes all the contents of the database of a kernel to the console    ###
######################################################################################


import redis
import pickle
from collections import Counter
from os.path import join
from glob import glob, iglob
from pprint import pprint


DIR = './save/machsuite/gemm-ncubed'
KERNEL = 'gemm-ncubed'
BENCHMARK = 'machsuite'
gexf_file = './machsuite/dot-files/gemm-ncubed_kernel.cpp.gexf'
# db_path = './machsuite/databases/**/*'
db_path = f'./{BENCHMARK}/databases/**/*'
reference_point = []  
reference_point.append({'__PARA__L0': 8, '__PARA__L1': 1, '__PARA__L2': 1, '__PIPE__L0': 'flatten', '__PIPE__L1': 'off', '__TILE__L0': 1, '__TILE__L1': 1})

# run "resid-server" on command line first!
def get_db_object(db_path, normalize_perf=False):
    # create a redis database
    database = redis.StrictRedis(host='localhost', port=6379)
    database.flushdb()

    db_files = [f for f in iglob(db_path, recursive=True) if f.endswith('.db') and KERNEL in f and BENCHMARK in f]
    print('database files:')
    pprint(db_files)
    # load the database and get the keys
    # the key for each entry shows the value of each of the pragmas in the source file
    for idx, file in enumerate(db_files):
        f_db = open(file, 'rb')
        data = pickle.load(f_db)
        database.hmset(0, data)
        max_idx = idx + 1
    keys = [k.decode('utf-8') for k in database.hkeys(0)]

    keys = sorted(keys)
    points = {}
    zero_count = 0
    nonzero_count = 0
    diff_label = 0
    count_lv1_invalid = 0
    count_lv2_invalid = 0
    perf_seen = Counter()
    all_perfs = []
    count_filtered = 0
    count_filtered_nonzero = 0
    min_perf = float('inf')
    stop = True
    all_points = {}
    for i in range(len(keys)):
        pickle_obj = database.hget(0, keys[i])
        obj = pickle.loads(pickle_obj)
        if type(obj) is int or type(obj) is dict:
            continue
        if keys[i][0:3] == 'lv1' and obj.perf == 0: ## lv1: merlin code transformation
            count_lv1_invalid += 1
        if keys[i][0:3] == 'lv2' and obj.perf == 0: ## lv2: hls synthesis
            count_lv2_invalid += 1

        if not stop: 
            for reference in reference_point:
                found = True
                for p in reference:
                    if obj.point[p] != reference[p]:
                        found = False
                        #print(f'different at {p}, {obj.point[p]} vs {reference_point[p]}')
                        break
                if found:
                    print(f'point exists with perf: {obj.perf}')
                    attrs = vars(obj)
                    print(', '.join("%s: %s" % item for item in attrs.items()))
        
        s = str(obj.point.values())
        all_points[(obj.perf, keys[i])] = (obj.point, obj.res_util)
        if obj.perf != 0 and obj.perf < min_perf:
            min_perf = obj.perf
            print(min_perf, obj.point)
        if s not in points:
            points[s] = (i, keys[i], obj.perf, obj.ret_code)
        else:
            diff_label_bool = obj.perf != points[s][2]
            if diff_label_bool:
                diff_label += 1
        perf_seen[obj.perf] += 1
        if obj.perf != 0.0:
            all_perfs.append(obj.perf)
        if obj.perf == 0:
            zero_count += 1
        else:
            nonzero_count += 1

    print(min(all_perfs))
    f_db.close()
    for (perf, key), (point, util) in sorted(all_points.items()):
        print(f'perf: {perf} for point: {point} with util: {util}')




if __name__ == '__main__':
    get_db_object(db_path)

    """
    # other variables that exists:
    ## obj.perf  --> the cycle counts of the given configuration
    ## obj.res_util --> the resource utilization for each type of the resourse (BRAM, DSP, LUT, FF)
    ##		    the variables "util_*" show the percentage of utilization
    ##		    the variables "total_*" show the exact number of resources used
    ## obj.eval_time --> how long it took for the tool to synthesize the given configuration
    ## obj.point --> the same as key. shows the value of each pragma
    ## obj.quality --> quality of the given design point as a measure of finite difference as defined in the paper 
    ##		   (ratio of difference of cycle and utilization compared to a base design)
    """
