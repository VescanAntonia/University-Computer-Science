#pragma once
#include "Repository.h"

class Controller {
private:
	Repository& repository;
public:
	explicit Controller(Repository& repo);
	std::vector<Dog> getAllController();
	unsigned int getNrElemsController();
	unsigned int getCapacityController();
	void addController(const std::string& breed, const std::string& name, int age, const std::string& photograph);
	void removeController(const std::string &breed,const std::string& name);
	void updateController(const std::string& old_breed, const std::string& old_name, const std::string& new_breed, const std::string& new_name, int age, const std::string& new_photograph);
	void getFilteredDogs(std::vector<Dog>& valid_dogs, const std::string& given_breed, int given_age);
	~Controller();
};