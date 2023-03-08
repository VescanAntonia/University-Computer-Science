#include "TurboEngine.h"
#include <string>
using namespace std;

TurboEngine::TurboEngine(std::string fuelType, std::size_t basePrice):
	Engine{fuelType,basePrice} 
{
}

TurboEngine::TurboEngine()
{
}

TurboEngine::~TurboEngine()
{
}

std::size_t TurboEngine::getPrice()
{
	this->basePrice;
}

std::string TurboEngine::toString() 
{
	return "Turbo Engine with the fuel type: "+ this->fuelType+" Base price: "+to_string(this->getPrice());
}
