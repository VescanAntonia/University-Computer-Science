#include "TestUserController.h"
#include <cassert>

void testUserController()
{
	auto* dynVector = new DynamicVector<Dog>(10);
	auto* repo = new Repository(dynVector);
	repo->init_repo();
	auto* dynVector2 = new DynamicVector<Dog>(10);
	auto* userRepo = new UserRepository(dynVector2);
	UserController userController = UserController(repo, userRepo);
	assert(userController.getNrElementsUserController() == 0);
	assert(userController.getCapacityUserController() == 10);
	Dog dog = repo->getAllRepo()[0];
	userController.addUserController(dog);
	assert(userController.getNrElementsUserController() == 1);
	assert(userController.getAllUserController()[0].get_name() == "Leila");
	Dog* validDog1 = new Dog[10];
	string empty;
	empty[0] = '\0';
	int counter1 = userController.getFilteredDogs(validDog1, empty, 11);
	assert(counter1 == 8);
	Dog* validDogs2 = new Dog[10];
	int counter2 = userController.getFilteredDogs(validDogs2, "Labrador", 10);
	assert(counter2 == 9);
}
