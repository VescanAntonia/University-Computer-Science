#include "Repository.h"

Patient* Repository::get_patients_repo()
{
    return this->patients.getAllElements();
}

int Repository::removeRepo(int pos)
{
    //this->patients.remove()
    this->patients.remove(pos);
    return 1;
}

int Repository::getNrelRepo()
{
    return this->patients.getSize();
}

int Repository::addRepo(const Patient& p)
{
    this->patients.add(p);
    return 1;
}

int Repository::existsByName(const std::string& name)
{
    return this->patients.testExistByName(name);
}
