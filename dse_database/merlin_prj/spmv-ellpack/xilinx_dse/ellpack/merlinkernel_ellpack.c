#include "merlin_type_define.h"
#pragma ACCEL kernel

void ellpack(double nzval[4940],int cols[494 * 10],double vec[494],double out[494])
{
  int i;
  int j;
  double Si;
  ellpack_1:
  for (i = 0; i < 494; i++) {
    double sum = out[i];
    ellpack_2:
    for (j = 0; j < 10; j++) {
      Si = nzval[j + i * 10] * vec[cols[j + i * 10]];
      sum += Si;
    }
    out[i] = sum;
  }
}
