#include "stddef.h"
#include "app_util_platform.h"

int main()
{
    app_util_critical_region_enter(NULL);
    return 0;
}