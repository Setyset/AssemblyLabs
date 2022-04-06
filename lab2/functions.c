
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

double* calcs(double, double);

int main(int argc, const char* argv[])
{
    double integer1, integer2;
    printf("Set value for x: ");
    scanf("%lf", &integer1);
    printf("x = %lf\n", integer1);
    printf("Set value for a: ");
    scanf("%lf", &integer2);
    printf("a = %lf\n", integer2);

    double* result = calcs(integer1, integer2);
    for (int i = 0; i < 10; i++)
    {
        fprintf(stdout, "%20.7lf\n", result[i]);
    }
    return 0;
}