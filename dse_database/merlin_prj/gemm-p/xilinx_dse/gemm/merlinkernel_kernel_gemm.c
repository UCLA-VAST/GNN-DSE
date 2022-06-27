#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_gemm(int ni,int nj,int nk,double alpha,double beta,double C[60][70],double A[60][80],double B[80][70])
{
  int i;
  int j;
  int k;
//BLAS PARAMS
//TRANSA = 'N'
//TRANSB = 'N'
// => Form C := alpha*A*B + beta*C,
//A is NIxNK
//B is NKxNJ
//C is NIxNJ
  
#pragma scop
  for (i = 0; i < 60; i++) {
    for (j = 0; j < 70; j++) {
      C[i][j] *= beta;
    }
    for (k = 0; k < 80; k++) {
      for (j = 0; j < 70; j++) {
        C[i][j] += alpha * A[i][k] * B[k][j];
      }
    }
  }
  
#pragma endscop
}
