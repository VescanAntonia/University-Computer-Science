#include "UserController.h"

UserController::UserController(Repository* repository1, UserRepository* userRepository1)
{
	this->repository = repository1;
	this->userRepository = userRepository1;
}

Dog* UserController::getAllUserController()
{
	return this->userRepository->getAllUserRepo();
}

int UserController::getNrElementsUserController()
{
	return this->userRepository->getNrElems();
}

int UserController::getCapacityUserController()
{
	return this->userRepository->getCapacity();
}

void UserController::addUserController(Dog dog)
{
	this->userRepository->addUserRepo(dog);
	string name = dog.get_name();
	string breed = dog.get_breed();
	int deleted_index = this->repository->findPosByBreedAndName(breed,name);
	this->repository->removeRepo(deleted_index);

}

int UserController::getFilteredDogs(Dog* valid_dogs, string given_breed, int given_age)
{
	int counter = 0;
	int length = this->repository->getNrElRepo();
	if (given_breed[0] == '\0')
		for (int i = 0; i < length; i++)
		{
			Dog current_dog = this->repository->getAllRepo()[i];
			if (given_age > current_dog.get_age())
			{
				valid_dogs[counter] = current_dog;
				counter++;
			}
		}
	else {
		for (int i = 0; i < length; i++)
		{
			Dog current_dog = this->repository->getAllRepo()[i];
			if (given_breed == current_dog.get_breed() && given_age > current_dog.get_age());
			{
				valid_dogs[counter] = current_dog;
				counter++;
			}
		}
	}
	return counter;
}

UserController::~UserController() = default;
