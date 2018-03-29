/* cfunc.c */

double DotProduct(int n, const double x[], const double y[])
{
    double dotp = 0;
    int j;
    for (j = 0; j < n; ++j) {
        dotp += x[j] * y[j];
    }
    return dotp;
}
