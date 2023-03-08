#include "SourceFile.h"
#include <sstream>
#include <vector>

std::istream& operator>>(std::istream& in, SourceFile& p)
{
    std::string token, line;
    std::vector<std::string> res;
    std::getline(in, line);
    std::stringstream ss{ line };
    while (getline(ss, token, ','))
    {
        res.push_back(token);
    }
    if (res.size() != 4)
        return in;
    p.name = res[0];
    p.status = res[1];
    p.creator = res[2];
    p.reviewer = res[3];
    return in;
}

std::ostream& operator<<(std::ostream& out, SourceFile& p)
{
    out << p.getName() << "," << p.getStatus() << "," << p.getCreator() << "," << p.getReviewer();
    return out;
}
