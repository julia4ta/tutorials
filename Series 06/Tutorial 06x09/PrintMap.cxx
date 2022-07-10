#include <ccomplex>
#include <cstdint>

#include <iostream>
#include <map>
using namespace std;


/*
function printmap()
    res = ccall(("printmap_tR8l_void", "libPrintMap"), Nothing, ())
    return res::Nothing
end
*/
extern "C" void printmap_tR8l_void(
    
) {
    map<string, string> dog =
{
    {"name", "eggdog"},
    {"age", "2"},
    {"breed", "egg-dog mix"}
};

for (auto const& [key, val] : dog)
{
    cout << key << ":	" << val << endl;
}

}

