#pragma once
#include "Service.h"
#include <iostream>
#include <string>

using namespace std;

class UI {
private:
	Service service;
public:
	UI(Service& service);
	void start();
	static void printMenu();
	void printAll();
	void addBuilding();
	//~UI();
};