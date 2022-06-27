#include "merlin_type_define.h"
#pragma ACCEL kernel

void kernel_fdtd_2d(int tmax,int nx,int ny,double ex[60][80],double ey[60][80],double hz[60][80],double _fict_[40])
{
  int t;
  int i;
  int j;
//#pragma scop
  for (t = 0; t < 40; t++) {
    for (j = 0; j < 80; j++) 
      ey[0][j] = _fict_[t];
    for (i = 1; i < 60; i++) 
      for (j = 0; j < 80; j++) 
        ey[i][j] = ey[i][j] - 0.5 * (hz[i][j] - hz[i - 1][j]);
    for (i = 0; i < 60; i++) 
      for (j = 1; j < 80; j++) 
        ex[i][j] = ex[i][j] - 0.5 * (hz[i][j] - hz[i][j - 1]);
    for (i = 0; i < 60 - 1; i++) 
      for (j = 0; j < 80 - 1; j++) 
        hz[i][j] = hz[i][j] - 0.7 * (ex[i][j + 1] - ex[i][j] + ey[i + 1][j] - ey[i][j]);
  }
//#pragma endscop
}
