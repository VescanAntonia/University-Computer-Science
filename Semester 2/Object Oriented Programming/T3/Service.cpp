#include "Service.h"

Service::Service(Repository& repo1): repo{repo1}
{
}

std::vector<Equation> Service::getAllService()
{
	return this->repo.getAll();
}
