#pragma once
#include<vector>
#include "Block.h"
#include "House.h"
#include "Building.h"
#include <string>

class Repository {
public:
	Repository();
	~Repository();
	void addBuilding(Building* newBuilding);
	std::vector<Building*> getAllBuildings();
	std::vector<Building*> getAllRestored(int year);
	std::vector <Building*> getAllDemolished();

private:
	std::vector<Building*> elements;
};