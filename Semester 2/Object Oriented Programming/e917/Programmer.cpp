#include "Programmer.h"
#include <sstream>
#include <vector>

std::istream& operator>>(std::istream& in, Programmer& p)
{
    std::string token, line;
    std::vector<std::string> res;
    std::getline(in, line);
    std::stringstream ss{ line };
    while (getline(ss, token, ','))
    {
        res.push_back(token);
    }
    if (res.size() != 3)
        return in;
    p.name = res[0];
    p.numberRevisedFiles = stoi(res[1]);
    p.totalNrOfFiles = stoi(res[2]);
    return in;
}

std::ostream& operator<<(std::ostream& out, Programmer& p)
{
    out << p.getName() << "," + p.getNumberRevised() << "," << p.getTotalFiles();
    return out;
}
