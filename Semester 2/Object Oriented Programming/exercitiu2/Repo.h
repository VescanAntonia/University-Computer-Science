#pragma once
#include "TurboEngine.h"
#include "ElectricEngine.h"
#include "Engine.h"
#include <vector>

class Repository {
private:
	std::vector<Engine*> elements;
public:
	Repository();
	~Repository();
	std::vector<Engine*> getAll();
	void creatEngine();
	void addCar();
};