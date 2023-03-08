#include "Repository.h"
#include<string>

Repository::Repository(DynamicVector<Dog>* repo_array)
{
	this->Dogs = repo_array;
}

void Repository::addRepo(const Dog& dog)
{
	//if (this->Dogs->testExistUnicity(dog) == -1)
	//{
	this->Dogs->add(dog);
		//return 1;
	//}
	//return 0;
}

void Repository::init_repo()
{
	Dog dog1 = Dog("Labrador", "Leila", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	Dog dog2 = Dog("German Shepherd", "Bruno", 12, "http://www.zooland.ro/data/articles/39/652/2005421143847lup-0n.jpg");
	Dog dog3 = Dog("Akita Inu", "Thor", 5, "https://s3.publi24.ro/vertical-ro-f646bd5a/extralarge/20190815/1351/fadb271780baa1710c1b2b7708635aa3.jpg");
	Dog dog4 = Dog("Husky", "Max", 4, "https://extrucan.ro/wp-content/uploads/2021/08/Siberian-Husky.jpg");
	Dog dog5 = Dog("Golder Retriever", "Bailey", 7, "https://www.animalepierdute.ro/wp-content/uploads/2019/08/golden-retriver-caine-de-rasa.jpg");
	Dog dog6 = Dog("Chow Chow", "Lana", 4, "https://www.perfectdogbreeds.com/wp-content/uploads/2020/04/Chow-Chow-What-to-Know-Before-Buying-Cover.jpg");
	Dog dog7 = Dog("Beagle", "Milo", 3, "https://www.zooplus.ro/ghid/wp-content/uploads/2021/07/caine-beagle-768x512.jpeg");
	Dog dog8 = Dog("Bulldog", "Buddy", 7, "https://cdn.britannica.com/05/30105-004-644BE36D.jpg");
	Dog dog9 = Dog("Shiba Inu", "Bentley", 8, "https://pisicutesicaini.ro/wp-content/uploads/2021/06/Shiba-Inu-standing-in-profile-outdoors.jpg");
	Dog dog10 = Dog("Rottweiler", "Ollie", 9, "https://www.animaland.ro/wp-content/uploads/2022/03/rott1-1200x900.jpg");
	this->Dogs->add(dog1);
	this->Dogs->add(dog2);
	this->Dogs->add(dog3);
	this->Dogs->add(dog4);
	this->Dogs->add(dog5);
	this->Dogs->add(dog6);
	this->Dogs->add(dog7);
	this->Dogs->add(dog8);
	this->Dogs->add(dog9);
	this->Dogs->add(dog10);


}

//Dog Repository::findByBreedAndName(const std::string& breed, const std::string& name)
//{
//	Dog* dogsInArray = this->Dogs->getAllElements();
//	if (dogsInArray == NULL)
//		return Dog{};
//	for (int i = 0; i < this->Dogs->getSize(); i++)
//	{
//		Dog d = dogsInArray[i];
//		if (d.get_breed() == breed && d.get_name() == name)
//			return d;
//	}
//	return Dog{};
//}

void Repository::removeRepo(int pos)
{
	this->Dogs->remove(pos);
	//return 1;
	//if (this->Dogs.testExistUnicity(dog) != -1)
	//{
		//int pos = this->Dogs.testExistUnicity(dog);
		//this->Dogs.remove(pos);
		//return 1;
	//}
	//return 0;

}

void Repository::updateRepo(int pos, const Dog& dog2)
{
	//if (this->Dogs->testExistUnicity(dog1) != -1)
	//{
		//int pos = this->Dogs->testExistUnicity(dog1);
	this->Dogs->update(pos, dog2);
		//return 1;
	//}
	//return 0;
}

int Repository::findPosByBreedAndName(string breed, string name)
{
	if (this->Dogs->getSize() == 0)
		return -1;
	int length = this->getNrElRepo();
	int pos = -1;
	for (int i = 0; i < length; i++)
	{
		Dog randomDog = this->Dogs->getElement()[i];
		string randomName = randomDog.get_name();
		string randomBreed = randomDog.get_breed();
		if (randomBreed == breed && randomName == name)
			pos = i;
	}
	//int pos = this->Dogs->testExistByBreedAndName(breed, name);
	return pos;
}

Dog* Repository::getAllRepo()
{
	return this->Dogs->getAllElements();
	//return DynamicVector<Dog>();
}

int Repository::getNrElRepo()
{
	return this->Dogs->getSize();
}

int Repository::getCapacityRepo()
{
	return this->Dogs->getCap();
}

Repository::~Repository() = default;
