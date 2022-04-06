#include <stdio.h>
long* calcs(long, long);
int main()
{
    long integer1, integer2;
    printf("Set value for x: ");
    scanf("%ld", &integer1);
    printf("x = %ld\n", integer1);
    printf("Set value for y: ");
    scanf("%ld", &integer2);
    printf("y = %ld\n", integer2);
    long* result = calcs(integer1, integer2);
    printf("\n(XY - 1) / (X + Y) = %ld\n", result[0]);
    printf("X^3 + Y - 1 = %ld\n", result[1]);
    printf("(XY + 1) / X^2 =  %ld\n", result[2]);
    printf("(X + Y)/(X - Y) =  %ld\n", result[3]);
    printf("-X^3 + 3 =  %ld\n", result[4]);
    return 0;
}
