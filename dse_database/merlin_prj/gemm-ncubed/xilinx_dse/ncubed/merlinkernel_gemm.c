#include "merlin_type_define.h"
#pragma ACCEL kernel

void gemm(double m1[4096],double m2[4096],double prod[4096])
{
  int i;
  int j;
  int k;
  int k_col;
  int i_col;
  double mult;
  outer:
  for (i = 0; i < 64; i++) {
    middle:
    for (j = 0; j < 64; j++) {
      i_col = i * 64;
      double sum = (double )0;
      inner:
      for (k = 0; k < 64; k++) {
        k_col = k * 64;
        mult = m1[i_col + k] * m2[k_col + j];
        sum += mult;
      }
      prod[i_col + j] = sum;
    }
  }
}
