#include "Engine.h"
#include <string>
#include <iostream>
using namespace std;

Engine::Engine(std::string fuelType1, std::size_t basePrice):
	fuelType{fuelType1}, basePrice{basePrice}
{
}

Engine::Engine()
{
}

std::string Engine::getFuelType() const
{
	return this->fuelType;
}

std::string Engine::getType() const
{
	return this->type;
}

std::string Engine::toString()
{
	return "Engine: "+ this->type+" | Fuel type: "+this->fuelType+" Base Price: "+ to_string(this->basePrice);
}

Engine::~Engine()
{
}
