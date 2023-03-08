#include "Car.h"

Car::Car(std::string fuelType, std::size_t basePrice, std::string bodyStyle):
	Engine{fuelType,basePrice}, bodyStyle(bodyStyle)
{
}

Car::Car()
{
}

std::string Car::getBodyStyle() const
{
	return this->bodyStyle;
}

double Car::computePrice()
{
	double price = 0;
	if (this->type == "turbo")
	{
		if (this->fuelType == "gasoline")
			price = this->basePrice + 0.01 * 100;
		else if (this->fuelType == "diesel")
			price = this->basePrice + 0.01 * 150;
	}
	else if (this->type == "electric")
		//price=this->basePrice+this->
		price = 0;
}

Car::~Car()
{
}
