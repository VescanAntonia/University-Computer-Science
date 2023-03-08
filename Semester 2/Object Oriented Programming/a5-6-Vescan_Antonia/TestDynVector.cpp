#include "TestDynVector.h"
#include <cassert>
#include <cstring>

void testDynVector()
{
	auto* dynamicVector = new DynamicVector<TElem>(1);
	assert(dynamicVector->getCap() == 1);
	assert(dynamicVector->getSize() == 0);
	try {
		auto* dynamicArrayInvalid = new DynamicVector<TElem>(0);
	}
	catch (const char* msg) {
		assert(strcmp(msg, "Incorrect capacity! ") == 0);
	}
	TElem el1 = nullptr;
	dynamicVector->add(el1);
	assert(dynamicVector->getSize() == 1);
	TElem el2 = nullptr;
	dynamicVector->add(el2);
	assert(dynamicVector->getSize() == 2);
	assert(dynamicVector->getCap() == 2);
	TElem el3 = nullptr;
	dynamicVector->update(1, el3);
	assert(dynamicVector->getElement()[1] == el3);
	TElem el4 = nullptr;
	dynamicVector->add(el4);
	dynamicVector->remove(1);
	assert(dynamicVector->getSize() == 2);
	assert(dynamicVector->getElement()[1] == el4);
}
