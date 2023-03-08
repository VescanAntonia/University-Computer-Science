#include "TestController.h"
#include <cassert>

void testController()
{
	auto* dynamicVector = new DynamicVector<Dog>(10);
	auto* repo = new Repository(dynamicVector);
	repo->init_repo();
	Controller controller = Controller(repo);
	assert(controller.getAllController()[0].get_name() == "Leila");
	assert(controller.getCapacityController() == 10);
	assert(controller.getNrElController() == 10);
	int added = controller.addDogRepository("Labrador", "Elena", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(added == 0);
	assert(controller.getNrElController() == 11);
	assert(controller.getCapacityController() == 20);
	added = controller.addDogRepository("Labrador", "Elena", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(added == 1);
	int deleted = controller.removeDogRepository("Labrador", "Elena");
	assert(deleted == 0);
	assert(controller.getNrElController() == 10);
	int deleted1 = controller.removeDogRepository("l", "El");
	assert(deleted1 == 1);
	int updated = controller.updateDogRepository("Labrador", "Leila", "Labrador", "Emi", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(updated == 0);
	updated = controller.updateDogRepository("Husky","Bobi", "B", "Jacob", 3, "https://www.sksk");
	assert(updated == 1);
}
