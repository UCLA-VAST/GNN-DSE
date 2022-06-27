#include "merlin_type_define.h"
#pragma ACCEL kernel

void spmv(double val[1666],int cols[1666],int rowDelimiters[494 + 1],double vec[494],double out[494])
{
  int i;
  int j;
  double sum;
  double Si;
  spmv_1:
  for (i = 0; i < 494; i++) {
    sum = ((double )0);
    Si = ((double )0);
    int tmp_begin = rowDelimiters[i];
    int tmp_end = rowDelimiters[i + 1];
    spmv_2:
    for (j = tmp_begin; j < tmp_end; j++) {
      Si = val[j] * vec[cols[j]];
      sum = sum + Si;
    }
    out[i] = sum;
  }
}
