#pragma once
#include "Engine.h"

class Car :public Engine {
private:
	std::string bodyStyle;
public:
	Car(std::string fuelType, std::size_t basePrice, std::string bodyStyle);
	Car();
	std::string getBodyStyle() const;
	double computePrice();
	~Car();

};