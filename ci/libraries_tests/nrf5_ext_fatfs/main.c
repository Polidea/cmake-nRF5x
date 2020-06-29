#include "ff.h"

int main()
{
    static FATFS fs;
    f_mount(&fs, "", 1);

    return 0;
}
