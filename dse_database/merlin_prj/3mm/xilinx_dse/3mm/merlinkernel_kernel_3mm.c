#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_3mm(int ni,int nj,int nk,int nl,int nm,double E[40][50],double A[40][60],double B[60][50],double F[50][70],double C[50][80],double D[80][70],double G[40][70])
{
  int i;
  int j;
  int k;
//#pragma scop
/* E := A*B */
  for (i = 0; i < 40; i++) {
    for (j = 0; j < 50; j++) {
      E[i][j] = 0.0;
      for (k = 0; k < 60; ++k) {
        E[i][j] += A[i][k] * B[k][j];
      }
    }
  }
/* F := C*D */
  for (i = 0; i < 50; i++) {
    for (j = 0; j < 70; j++) {
      F[i][j] = 0.0;
      for (k = 0; k < 80; ++k) {
        F[i][j] += C[i][k] * D[k][j];
      }
    }
  }
/* G := E*F */
  for (i = 0; i < 40; i++) {
    for (j = 0; j < 70; j++) {
      G[i][j] = 0.0;
      for (k = 0; k < 50; ++k) {
        G[i][j] += E[i][k] * F[k][j];
      }
    }
  }
//#pragma endscop
}
