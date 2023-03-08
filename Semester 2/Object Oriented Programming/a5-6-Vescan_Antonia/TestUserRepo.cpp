#include "TestUserRepo.h"
#include <cassert>

void testUserRepo()
{
	auto* dynamicVector = new DynamicVector<Dog>(2);
	UserRepository userRepo = UserRepository(dynamicVector);
	assert(userRepo.getCapacity() == 2);
	Dog dog1 = Dog("German Shepherd,Bruno,12,http://www.zooland.ro/data/articles/39/652/2005421143847lup-0n.jpg");
	Dog dog2 = Dog("Akita Inu,Thor,5,https://s3.publi24.ro/vertical-ro-f646bd5a/extralarge/20190815/1351/fadb271780baa1710c1b2b7708635aa3.jpg");
	userRepo.addUserRepo(dog1);
	assert(userRepo.getNrElems()==1);
	userRepo.addUserRepo(dog2);
}
