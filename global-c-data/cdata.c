#include <stdlib.h>

/* cdata.c */

/* define some global data items and their initialization routine */

short int pixel[2][4] = { 0 };

#define NSIZE 3

int n = 0;
float *vector;

typedef struct {
    double x, y;
    int id;
    double z;
} pos_t;

pos_t position;

void cinit()
{
    int i, j;
    short int cnt = 0;

    for (j = 0; j < 2; ++j) {
        for (i = 0; i < 4; ++i) {
            pixel[j][i] = ++cnt;
        }
    }

    vector = malloc(NSIZE * sizeof(*vector));
    n = NSIZE;
    for (j = 0; j < NSIZE; ++j) {
        vector[j] = -j;
    }

    position.x = 11;
    position.y = 22;
    position.id = 1;
    position.z = 33;  
}
