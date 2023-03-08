#pragma once
#include "Engine.h"
#include <string>

class TurboEngine :public Engine {
public:
	TurboEngine(std::string fuelType, std::size_t basePrice);
	TurboEngine();
	~TurboEngine();
	std::size_t getPrice() override;
	std::string toString() override;

};