#include "merlin_type_define.h"
#pragma ACCEL kernel

void stencil(int orig[128 * 64],int sol[128 * 64],int filter[9])
{
  int r;
  int c;
  int k1;
  int k2;
  int temp;
  int mul;
  stencil_label1:
  for (r = 0; r < 128 - 2; r++) {
    stencil_label2:
    for (c = 0; c < 64 - 2; c++) {
      temp = ((int )0);
      stencil_label3:
      for (k1 = 0; k1 < 3; k1++) {
        stencil_label4:
        for (k2 = 0; k2 < 3; k2++) {
          mul = filter[k1 * 3 + k2] * orig[(r + k1) * 64 + c + k2];
          temp += mul;
        }
      }
      sol[r * 64 + c] = temp;
    }
  }
}
