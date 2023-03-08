#include "UI.h"
#include <string>
#include <iostream>
using namespace std;


UI::UI(Controller* ctrl, UserController* userctrl)
{
	this->ctrl = ctrl;
	this->userctrl = userctrl;
}

void UI::printMenu()
{
	cout << endl;
	cout << "1 - Manage dog repository." << endl;
	cout << "2 - Manage adoption list." << endl;
	cout << "0 - Exit." << endl;
}

void UI::printRepositoryMenu()
{
	cout << "Possible commands: " << endl;
	cout << "\t 1 - Add dog." << endl;
	cout << "\t 2 - Display all dogs." << endl;
	cout << "\t 3 - Remove a dog." << endl;
	cout << "\t 4 - Update a dog." << endl;
	cout << "\t 0 - Back to the main menu." << endl;
}

void UI::printAdoptionListMenu()
{
	cout << "Possible commands: " << endl;
	cout << "\t 1 - See the dogs one by one." << endl;
	cout << "\t 2 - See all the dogs of a given breed, having an age less than a given number." << endl;
	cout << "\t 3 - See adoption list." << endl;
	cout << "\t 0 - Back to the main menu." << endl;
}

void UI::addDogToRepository()
{
	cout << " Enter the breed: ";
	string breed;
	getline(cin, breed);
	if ((!stringValidator(breed)) || (breed.length() == 0))
		throw "Breed input is invalid! ";
	cout << " Enter the name: ";
	string name;
	getline(cin, name);
	if ((!stringValidator(name)) || (name.length() == 0))
		throw "Name input is invalid! ";
	string age;
	cout << " Enter the age:";
	getline(cin, age);
	int age2;
	if (!stringValidator(age) && age.length() != 0)
		age2 = stoi(age);
	else
		throw "Age input not valid!";
	if (age2 < 0)
		throw "Age cannot be smaller than 0!";
	cout << " Enter photo link:";
	string link;
	getline(cin, link);
	if (link.length() == 0 || link.find("www") == string::npos)
		throw "Photograph link is not valid!";
	int added = this->ctrl->addDogRepository(breed, name, age2, link);
	if (added == 1)
		cout << "\t The dog could't be added! ";
	else if (added==0)
		cout << "\t Added succesfully! ";
}

void UI::displayalldogsRepo()
{
	Dog* dogs = this->ctrl->getAllController();
	int i=0;
	int elem = this->ctrl->getNrElController();
	if (elem == 0)
		cout<<"\t There are no dogs in the repository. " << endl;
	for (i = 0; i < elem; i++)
		//cout << dogs[i].get_breed() << "-" << dogs[i].get_name() << "-" << dogs[i].get_age() << "-" << dogs[i].get_photograph() << endl;
		cout << i + 1 << "." << dogs[i].convert() << endl;
	//cout << dogs->get_breed();
	//if (this->ctrl.getRepo().getDogs().getSize() == 0)
	//{
	//	cout << "\t There are no dogs in the repository. " << endl;
	//	return;
	//}
	//for (int i = 0; i < this->ctrl.getRepo().getDogs().getSize(); i++)
	////for (auto d : dogs1)
	//{
	//	Dog d = dogs[i];
	//	cout << d.get_breed() << "-" << d.get_name() << "-" << d.get_age() << "-" << d.get_photograph() << endl;
	//}
}

bool UI::stringValidator(string givenString)
{
	for (int i = 0; i < givenString.length(); i++)
		if (isdigit(givenString[i]) != false)
			return false;
	return true;
}

void UI::removeDogFromRepository()
{
	cout << " Enter the breed: ";
	string breed;
	getline(cin, breed);
	if (!stringValidator(breed) || breed.length() == 0)
		throw "Bred is not valid!";
	cout << " Enter the name: ";
	string name;
	getline(cin, name);
	if (!stringValidator(name) || name.length() == 0)
		throw "Name is not valid!";
	//int age = 0;
	//cout << " Enter the age:";
	//cin >> age;
	//cin.ignore();
	//cout << " Enter photo link:";
	//std::string link;
	//getline(cin, link);
	int deleted = this->ctrl->removeDogRepository(breed,name);
	if (deleted == 0)
		cout << "\t Removed succesfully! "<<endl;
	else
		cout << "\t The dog does not exist! "<<endl;
}

void UI::updateDogFromRepository()
{
	cout << " Enter the breed of the dog you would like to update: ";
	std::string breed;
	getline(cin, breed);
	cout << " Enter the name of the dog you would like to update: ";
	std::string name;
	getline(cin, name);

	cout << " Enter the breed of the dog you would like to update: ";
	std::string newbreed;
	getline(cin, newbreed);
	cout << " Enter the name of the dog you would like to update: ";
	std::string newname;
	getline(cin, newname);
	int age = 0;
	cout << " Enter the age:";
	cin >> age;
	cin.ignore();
	cout << " Enter photo link:";
	std::string link;
	getline(cin, link);
	int updated = this->ctrl->updateDogRepository(breed,name,newbreed,newname,age,link);
	if (updated == -1)
		cout << "\t The dog does not exist! " << endl;
	else
		cout << "\t Updated succesfully! "<< endl;
}
//
//void UI::addDogAdoptionList()
//{
//	//TODO
//}


void UI::run()
{
	while (true)
	{
		UI::printMenu();
		string command;
		cout << "Input the command: ";
		getline(cin,command);
		if (command == "0")
			break;
		else if (command == "1")
			administratorMode();
		else if (command == "2")
			userMode();
		else
			cout << "Invalid input" << endl;
		
	}

}

void UI::userMode()
{
	cout << "~This is user mode.~" << endl;
	while (true) {
		try {
			printAdoptionListMenu();
			string option;
			cout << "Enter the option:";
			getline(cin,option);
			if (option == "0")
				break;
			else if (option == "1")
				this->listDogsUserOneByOne();
			else if (option == "2")
				this->listFilteredUserDogs();
			else if (option=="3")
				this->listAdoptionList();
			else cout << "Invalid input!" << endl;
			
		}
		catch (const char* msg) {
			cout << msg << endl;
		}
		catch (const exception& exc) {
			cerr << exc.what();
			cout << endl;
		}
	}
}

void UI::administratorMode()
{
	cout << "~This is the administrator mode.~" << endl;
	while (true) {
		try {
			printRepositoryMenu();
			string given_option;
			cout << "Enter the command:";
			getline(cin, given_option);
			if (given_option == "0")
				break;
			else if (given_option == "1")
				this->addDogToRepository();
				//break;
			else if (given_option=="2")
				this->displayalldogsRepo();
				//break;
			else if (given_option=="3")
				this->removeDogFromRepository();
				//break;
			else if (given_option=="4")
				this->updateDogFromRepository();
				//break;
			else
				cout << "Invalid input!" << endl;
		}catch (const char* msg) {
			cout << msg << endl;
		}
		catch (const exception& exc) {
			cerr << exc.what();
			cout << endl;
		}
	}
}


void UI::listDogsUserOneByOne()
{
	string option;
	int current_position = 0;
	int length = this->ctrl->getNrElController();
	if (length == 0)
		throw "There are no dogs to adopt.";
	while (true)
	{
		if (length == 0)
			throw "There are no more dogs";
		if (current_position == length)
			current_position = 0;
		cout << this->ctrl->getAllController()[current_position].convert() << endl;
		cout << "Adopt? [Yes / No / Exit]" << endl;
		string link = string("start ").append(this->ctrl->getAllController()[current_position].get_photograph());
		system(link.c_str());
		getline(cin, option);
		if (option == "Yes") {
			Dog* current_dog = this->ctrl->getAllController();
			this->userctrl->addUserController(current_dog[current_position]);
			length = this->ctrl->getNrElController();
		}
		else if (option == "No")
			current_position++;
		else if (option == "Exit")
			break;
		if (length == 0)
			break;


	}
}

void UI::listFilteredUserDogs()
{
	/*int len = (int)this->userctrl->getNrElementsUserController();
	if (len == 0) {
		throw "There is nothing to filter";}
	string given_breed;
	int age;
	cout << " Insert the breed: ";
	cin >> given_breed;
	cout << " Insert the age: ";
	cin >> age;
	bool still_going = true;
	for (int i = 0; i < len; i++) {
		string a_breed = userctrl->getAllUserController()[i].get_breed();
		int a_age = userctrl->getAllUserController()[i].get_age();
		if (still_going && a_breed == given_breed && a_age < age) {
			still_going = false;
			cout << " Filtered data: " << endl;
			cout << userctrl->getAllUserController()[i].convert() << endl;
		}
		else if (a_breed == given_breed && a_age < age) {
			cout << endl;
			cout << userctrl->getAllUserController()[i].convert() << endl;
		}
	}
	if (still_going == true)
		cout << " No results" << endl;*/
	string given_breed, given_age;
	int given_age2=0;
	cout << "Enter the breed: ";
	getline(cin, given_breed);
	if (!stringValidator(given_breed))
		throw "Invalid breed!";
	cout << "Enter the age: ";
	getline(cin, given_age);
	if (!stringValidator(given_age) && given_age.length() != 0)
		given_age2 = stoi(given_age);
	if ((int)given_age2 < 0)
		throw "Age cannot be smaller than 0";
	auto* validDogs = new Dog[this->ctrl->getCapacityController()];
	int length = this->userctrl->getFilteredDogs(validDogs,given_breed, given_age2);
	if (length == 0)
		throw "There are no dogs matching! ";
	string option;
	bool done = false;
	int index = 0;
 	while (!done) {
		if (length == 0)
			throw "No more dogs.";
		if (index == length)
			index = 0;
		cout << validDogs[index].convert() << endl;
		cout << "Adopt? [Yes / No / exit]" << endl;
		string link = string("start ").append(validDogs[index].get_photograph());
		system(link.c_str());
		getline(cin, option);
		if (option == "Yes") {
			Dog dog = validDogs[index];
			this->userctrl->addUserController(dog);
			for (int i = index; i < length - 1; i++)
				validDogs[i] = validDogs[i + 1];
			length--;
		}
		else if (option == "No") {
			index++;
		}
		else if (option == "exit")
			done = true;
	}
}

void UI::listAdoptionList()
{ 
	Dog* adoptionList = this->userctrl->getAllUserController();
	int length = this->userctrl->getNrElementsUserController();
	if (length == 0)
		throw "There are no adoptions to print.";
	for (int i = 0; i < length; i++)
		cout << i + 1 << " . " << adoptionList[i].convert() << endl;
}


UI::~UI() = default;