#include "Controller.h"
#include <cassert>

Controller::Controller(Repository* repo)
{
	this->repo = repo;
}

int Controller::addDogRepository(string breed, string name, int age, string photograph)
{
	//Dog d{ breed, name, age, photograph };
	//Dog dd = this->repo->findByBreedAndName(breed, name);
	//if (dd.get_breed() != "" || dd.get_name() != "")
		//return 0;
	for (int i = 0; i < this->repo->getNrElRepo(); i++)
	{
		string randomName = this->getAllController()[i].get_name();
		string randomBreed = this->getAllController()[i].get_breed();
		if (randomName == name && randomBreed == breed)
			return 1;
	}
	this->repo->addRepo(Dog(breed,name,age,photograph));
	return 0;
}

int Controller::removeDogRepository(string breed, string name)
{
	int pos = this->repo->findPosByBreedAndName(breed,name);
	if (pos == -1)
		return 1;
	this->repo->removeRepo(pos);
	return 0;
}

int Controller::updateDogRepository(string breed, string name, string newbreed, string newname, int newage,string newphotograph)
{
	int pos = this->repo->findPosByBreedAndName(breed, name);
	//int pos2 = this->repo->findPosByBreedAndName(newbreed, newname);
	if (pos == -1)
		return 1;
	//Dog d1 = this->repo->findByBreedAndName(breed, name);
	//int oldage = d1.get_age();
	//Dog OldDog{ breed,name,oldage,d1.get_photograph() };
	//Dog NewDog{ newbreed,newname, newage, newphotograph };
	Dog NewDog = Dog(newbreed, newname, newage, newphotograph);
	this->repo->updateRepo(pos, NewDog);
	//this->repo->updateRepo(OldDog, NewDog);
	return 0;

}

Dog* Controller::getAllController()
{
	return this->repo->getAllRepo();
}

int Controller::getNrElController()
{
	return this->repo->getNrElRepo();
}

int Controller::getCapacityController()
{
	return this->repo->getCapacityRepo();
}



//void Controller::testsController()
//{
//	Repository repo{};
//	Controller controller{ repo };
//	controller.addDogRepository("Labrador", "Lena", 15, "www.strabsnjm");
//	assert(controller.getNrElController() == 1);
//	assert(controller.addDogRepository("a", "b", 5, "c") == 1);
//	assert(controller.getNrElController() == 2);
//	assert(controller.removeDogRepository("a", "b") == 1);
//	assert(controller.getNrElController() == 1);
//	assert(controller.updateDogRepository("Labrador", "Lena", "Husky", "Elena", 5, "www") == 1);
//	assert(controller.repo.findPosByBreedAndName("Labrador", "Elena") == -1);
//
//}

Controller::~Controller() = default;


//DynamicVector<Dog> Controller::listDogs()
//{
//	return this->repo.getDogs();
//	//return DynamicVector<Dog>();
//}
