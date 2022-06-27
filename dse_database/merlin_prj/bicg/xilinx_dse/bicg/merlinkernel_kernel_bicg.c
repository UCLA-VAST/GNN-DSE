#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_bicg(int m,int n,double A[124][116],double s[116],double q[124],double p[116],double r[124])
{
  int i;
  int j;
//#pragma scop
  for (i = 0; i < 116; i++) {
    s[i] = ((double )0);
  }
  for (i = 0; i < 124; i++) {
    q[i] = 0.0;
    for (j = 0; j < 116; j++) {
      s[j] = s[j] + r[i] * A[i][j];
      q[i] = q[i] + A[i][j] * p[j];
    }
  }
//#pragma endscop
}
