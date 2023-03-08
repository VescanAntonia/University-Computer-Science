#include "TestRepo.h"
#include <cassert>

void testRepository()
{
	auto* dynamicVector = new DynamicVector<Dog>(10);
	Repository repo = Repository(dynamicVector);
	repo.init_repo();
	assert(repo.getNrElRepo() == 10);
	assert(repo.getCapacityRepo() == 10);
	assert(repo.getAllRepo()[0].get_name() == "Leila");
	Dog dog1 = Dog("Labrador", "Elena", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	repo.addRepo(dog1);
	assert(repo.getNrElRepo() == 11);
	assert(repo.getCapacityRepo() == 20);
	assert(repo.findPosByBreedAndName("Labrador","Leila") == 0);
	repo.removeRepo(0);
	assert(repo.getNrElRepo() == 10);
	Dog dog2 = Dog("Labrador", "Elen", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	repo.updateRepo(9, dog2);
	assert(repo.getAllRepo()[9].get_name() == "Elen");
	assert(repo.getAllRepo()[9].get_age() == 2);
}
