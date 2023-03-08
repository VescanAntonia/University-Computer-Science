#pragma once
#include <string>

class Engine {
protected:
	std::string fuelType;
	std::size_t basePrice;
	std::string type;
public:
	Engine(std::string fuelType1, std::size_t basePrice);
	Engine();
	std::string getFuelType() const;
	virtual size_t getPrice()=0;
	std::string getType()const;
	virtual std::string toString();
	~Engine();
};