// This is basically the same as procedure-asm.s
// but written in C.
// Run this against
// $ gcc -m32 -S
// to compare the resulting code with procedure-asm.s

int swap_add(int *xp, int *yp) {
  int x = *xp;
  int y = *yp;

  *xp = y;
  *yp = x;

  return x + y;
}

int caller() {
  int arg1 = 534;
  int arg2 = 1057;

  int sum = swap_add(&arg1, &arg2);
  int diff = arg1 - arg2;

  return sum * diff;
}

int main() {
  return caller();
}
