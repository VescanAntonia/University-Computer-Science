#pragma once
#include "Observer.h"
#include <vector>

class Subject {
private:
	std::vector<Observer*> repo;
public:
	void addObserver(Observer*obs);
	void removeObserver(Observer* obs);
	void notify();
};