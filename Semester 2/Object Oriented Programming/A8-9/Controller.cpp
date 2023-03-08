#include "Controller.h"

Controller::Controller(Repository& repo):repository(repo){}

std::vector<Dog> Controller::getAllController()
{
    return this->repository.getAllRepo();
}

unsigned int Controller::getNrElemsController()
{
    return this->repository.getNrElems();
}

unsigned int Controller::getCapacityController()
{
    return this->repository.getCapacity();
}

void Controller::addController(const std::string& breed, const std::string& name, int age, const std::string& photograph)
{
    Dog dog = Dog(breed, name, age, photograph);
    this->repository.addRepo(dog);
}

void Controller::removeController(const std::string&breed, const std::string& name)
{
    int removedIndex = this->repository.finddPosByBreedAndName(breed, name);
    this->repository.removeRepo(removedIndex);
}

void Controller::updateController(const std::string& old_breed, const std::string& old_name, const std::string& new_breed, const std::string& new_name, int age, const std::string& new_photograph)
{
    int updatedIndex = this->repository.finddPosByBreedAndName(old_breed, old_name);
    Dog new_dog = Dog(new_breed, new_name, age, new_photograph);
    this->repository.updateRepo(updatedIndex, new_dog);
}

void Controller::getFilteredDogs(std::vector<Dog>& valid_dogs, const std::string& given_breed, int given_age)
{
    //
}

Controller::~Controller() = default;
