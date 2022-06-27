#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_gesummv(int n,double alpha,double beta,double A[90][90],double B[90][90],double tmp[90],double x[90],double y[90])
{
  int i;
  int j;
  
#pragma scop
  for (i = 0; i < 90; i++) {
    tmp[i] = 0.0;
    y[i] = 0.0;
    for (j = 0; j < 90; j++) {
      tmp[i] = A[i][j] * x[j] + tmp[i];
      y[i] = B[i][j] * x[j] + y[i];
    }
    y[i] = alpha * tmp[i] + beta * y[i];
  }
  
#pragma endscop
}
