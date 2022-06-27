#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_gemver(int n,double alpha,double beta,double A[120][120],double u1[120],double v1[120],double u2[120],double v2[120],double w[120],double x[120],double y[120],double z[120])
{
  int i;
  int j;
  
#pragma scop
  for (i = 0; i < 120; i++) {
    for (j = 0; j < 120; j++) {
      A[i][j] = A[i][j] + u1[i] * v1[j] + u2[i] * v2[j];
    }
  }
  for (i = 0; i < 120; i++) {
    for (j = 0; j < 120; j++) {
      x[i] = x[i] + beta * A[j][i] * y[j];
    }
  }
  for (i = 0; i < 120; i++) {
    x[i] = x[i] + z[i];
  }
  for (i = 0; i < 120; i++) {
    for (j = 0; j < 120; j++) {
      w[i] = w[i] + alpha * A[i][j] * x[j];
    }
  }
  
#pragma endscop
}
