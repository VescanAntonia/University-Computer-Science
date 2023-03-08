#include "Service.h"
#include <algorithm>

std::vector<SourceFile> Service::getByFilename()
{
    std::vector<SourceFile> data = this->repo.get();
    std::sort(data.begin(), data.end(), [](SourceFile a, SourceFile b) {return a.getName() < b.getName(); });
    return data;
}

void Service::add(const std::string& name1, const std::string& status1, const std::string& creator1, const std::string& reviewer1)
{
    int found = 0;
    for (int i = 0; i < this->repo.get().size(); ++i) {
        if (this->repo.get()[i].getName() == name1)
            found = 1;
    }
    if (name1.empty())
        throw std::exception("Failed! No source added!");
    else if (found == 1)
        throw std::exception("Failed!Already there!");
    else {
        SourceFile s{ name1,status1,creator1,reviewer1 };
        this->repo.add(s);
        this->notify();
    }
}
