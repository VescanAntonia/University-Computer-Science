#include "Repo.h"
#include <string>

Repository::Repository()
{
}

Repository::~Repository()
{
}

void Repository::addBuilding(Building* newBuilding)
{
	this->elements.push_back(newBuilding);

}

std::vector<Building*> Repository::getAllBuildings()
{
	return this->elements;
}

//std::vector<Building*> Repository::getAllRestored(int year)
//{
//	
//}
//
//std::vector<Building*> Repository::getAllDemolished()
//{
//	return 5;
//}
