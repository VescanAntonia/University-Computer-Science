#include "Building.h"
#include <sstream>
#include <iostream>

Building::Building(std::string adress, std::size_t year):
	adress{adress}, year{year}
{
	
}

Building::Building()
{
}

Building::~Building()
{
}

std::string Building::getAdress()const
{
	return this->adress;
}

size_t Building::getYear() const
{
	return this->year;
}

std::string Building::getType()const
{
	return this->type;
}

void Building::setType(std::string type)
{
	this->type = type;
}

std::string Building::toString()
{
	std::stringstream buffer;
	buffer << "Building \n\t address: " << this->adress << " year: " << this->year << std::endl;
	return buffer.str();
	/*auto string_year = std::to_string(this->year);
	return "Building type: " + this->type + " | Adress: " + this->adress + " | Year: " + string_year;*/

}
