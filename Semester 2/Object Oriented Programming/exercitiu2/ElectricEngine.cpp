#include "ElectricEngine.h"
#include <string>
#include <iostream>
using namespace std;

ElectricEngine::ElectricEngine(std::string fuelType, std::size_t basePrice, std::size_t autonomy) :
	Engine{ fuelType,basePrice }, autonomy{ autonomy }
{
}

ElectricEngine::ElectricEngine()
{
}

std::size_t ElectricEngine::getPrice()
{
	this->basePrice;
}

std::string ElectricEngine::toString()
{
	return "Electric engine with autonomy : "+ to_string(this->autonomy) + " | Base price: "+to_string(this->basePrice)+" | Fuel type: " + this->fuelType;
}

std::size_t ElectricEngine::getAutonomy() const
{
	return this->autonomy;
}

ElectricEngine::~ElectricEngine()
{
}
