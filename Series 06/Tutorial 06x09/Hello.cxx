#include <ccomplex>
#include <cstdint>

#include <iostream>
using namespace std;


/*
function hello(s::Union{Cstring, AbstractString})
    res = ccall(("hello_tR8l_void_char_", "libHello"), Nothing, (Cstring,), s)
    return res::Nothing
end
*/
extern "C" void hello_tR8l_void_char_(
    char* s
) {
    cout << "Hello, " << s << "!" << endl;

}

