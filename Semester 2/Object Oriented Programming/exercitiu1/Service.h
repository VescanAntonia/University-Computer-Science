#pragma once
#include "Repo.h"

class Service {
private:
	Repository& repository;
public:
	Service(Repository& repo);
	void AddBuilding(Building* b);
	std::vector<Building*> getAllBuildings();
	~Service();
};