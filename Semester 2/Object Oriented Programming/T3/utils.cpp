#include "utils.h"

std::vector<std::string> split(const std::string& s, char sep)
{
    std::vector<std::string> v = { "" };
    for (auto c : s) {
        if ( c!=sep)
        {
            v.back() += c;
        }
        else {
            v.emplace_back("");
        }
    }
    return v;

}
