#pragma once
#include <string>
#include "Engine.h"

class ElectricEngine:public Engine {
private:
	std::size_t autonomy;
public:
	ElectricEngine(std::string fuelType, std::size_t basePrice, std::size_t autonomy);
	ElectricEngine();
	std::size_t getPrice() override;
	std::string toString() override;
	std::size_t getAutonomy()const;
	~ElectricEngine();
};