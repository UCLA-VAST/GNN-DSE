for kernel in mvt atax ## list other desired kernels
do
    python3 parallel_run_tool_dse.py --kernel $kernel --benchmark poly --root-dir ../ --redis-port "8888"
done
