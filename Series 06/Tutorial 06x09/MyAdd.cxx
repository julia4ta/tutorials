#include <ccomplex>
#include <cstdint>

#include <iostream>
using namespace std;


/*
function myadd(x::Int32, y::Int32)
    res = ccall(("myadd_tR8l_int32_t_int32_t_int32_t", "libMyAdd"), Int32, (Int32, Int32), x, y)
    return res::Int32
end
*/
extern "C" int32_t myadd_tR8l_int32_t_int32_t_int32_t(
    int32_t x,
    int32_t y
) {
    return x + y;

}

/*
function myadd(x::Float64, y::Float64)
    res = ccall(("myadd_tR8l_double_double_double", "libMyAdd"), Float64, (Float64, Float64), x, y)
    return res::Float64
end
*/
extern "C" double myadd_tR8l_double_double_double(
    double x,
    double y
) {
    return x + y;

}

