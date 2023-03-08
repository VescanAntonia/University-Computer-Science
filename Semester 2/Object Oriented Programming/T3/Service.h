#pragma once
#include "Repository.h"
#include <string>

class Service {
private:
	Repository& repo;
public:
	Service(Repository& repo1);
	std::vector<Equation> getAllService();
};