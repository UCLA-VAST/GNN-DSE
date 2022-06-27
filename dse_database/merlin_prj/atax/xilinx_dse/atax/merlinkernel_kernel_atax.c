#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_atax(int m,int n,double A[116][124],double x[124],double y[124],double tmp[116])
{
  int i;
  int j;
//#pragma scop
  for (i = 0; i < 124; i++) 
    y[i] = ((double )0);
  for (i = 0; i < 116; i++) {
    tmp[i] = 0.0;
    for (j = 0; j < 124; j++) 
      tmp[i] += A[i][j] * x[j];
    for (j = 0; j < 124; j++) 
      y[j] += A[i][j] * tmp[i];
  }
//#pragma endscop
}
