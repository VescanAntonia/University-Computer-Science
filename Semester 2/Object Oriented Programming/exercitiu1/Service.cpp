#include "Service.h"

Service::Service(Repository& repo):repository{repo}
{
}

void Service::AddBuilding(Building* b)
{
	this->repository.addBuilding(b);
}

std::vector<Building*> Service::getAllBuildings()
{
	return this->repository.getAllBuildings();
}

Service::~Service()
{
}
