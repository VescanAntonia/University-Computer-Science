#include "Controller.h"

Patient* Controller::get_patientscontroller()
{
    return this->repo.get_patients_repo();
}

int Controller::addController(const std::string& name, int age, bool infected, int room, bool quarantined)
{
    Patient p{ name,age,infected,room,quarantined };
    this->repo.addRepo(p);
    return 1;
}

int Controller::removeController(const std::string& name)
{
    int pos = this->repo.existsByName(name);
    if (pos == -1)
        return 0;
    this->repo.removeRepo(pos);
    return 1;
}

int Controller::getNRelController()
{
    return this->repo.getNrelRepo();
}
