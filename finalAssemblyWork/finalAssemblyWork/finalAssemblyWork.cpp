#include <iostream>
#include <conio.h>

extern "C" {
    void add_int(int*, int*, int*, int);
}
#define len 128


int main()
{

    alignas(16) int vector1[len];
    alignas(16) int vector2[len];
    alignas(16) int resultado[len];

    for (int i = 0; i < len; i++) {

        vector1[i] = i;
        vector2[i] = i;
    }

    add_int(vector1, vector2, resultado, len);

    for (int i = 0; i < len; i++) {
        printf("%d\n", resultado[i]);
    }

}
