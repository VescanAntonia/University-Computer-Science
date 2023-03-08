#include "UserRepo.h"

UserRepository::UserRepository(DynamicVector<Dog>* adoptionList2)
{
	this->adoptionList = adoptionList2;
}

Dog* UserRepository::getAllUserRepo()
{
	//return this->adoptionList->getAllElements();
	return this->adoptionList->getAllElements();
}

int UserRepository::getNrElems()
{
	return this->adoptionList->getSize();
}

int UserRepository::getCapacity()
{
	return this->adoptionList->getCap();
}

void UserRepository::addUserRepo(const Dog& dog)
{
	this->adoptionList->add(dog);
}

UserRepository::~UserRepository() = default;
