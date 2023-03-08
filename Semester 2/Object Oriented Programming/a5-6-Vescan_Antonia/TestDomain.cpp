#include "TestDomain.h"
#include <cassert>
#include <cstring>

void testDomain()
{
	Dog newDog("Labrador", "Leila", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(newDog.get_breed() == "Labrador");
	assert(newDog.get_name() == "Leila");
	assert(newDog.get_age() == 2);
	assert(newDog.get_photograph() == "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	auto ageString = to_string(newDog.get_age());
	string string = newDog.convert();
	assert(string == "Breed: Labrador |Name: Leila |Age: 2 |Photograph: https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	try {
		Dog newInvalid("Husky", "Bella", -1, "https://www");
	}
	catch (const char* msg) {
		assert(strcmp(msg, "Age can't be smaller than 0!")==0);
	}
}
