#include "Ui.h"
#include <iostream>

using namespace std;

UI::UI(Controller& controller, UserController& usercontroller, Validator& validator1) :controller(controller), usercontroller(usercontroller), validator(validator1) {}

void UI::printMenu()
{
	std::cout << std::endl;
	std::cout << "1 - Manage dog repository." << std::endl;
	std::cout << "2 - Manage adoption list." << std::endl;
	std::cout << "0 - Exit." << std::endl;
}

void UI::printRepositoryMenu()
{
	std::cout << "Possible commands: " << std::endl;
	std::cout << "\t 1 - Add dog." << std::endl;
	std::cout << "\t 2 - Display all dogs." << std::endl;
	std::cout << "\t 3 - Remove a dog." << std::endl;
	std::cout << "\t 4 - Update a dog." << std::endl;
	std::cout << "\t 0 - Back to the main menu." << std::endl;
}

void UI::printAdoptionListMenu()
{
	std::cout << "Possible commands: " << std::endl;
	std::cout << "\t 1 - See the dogs one by one." << std::endl;
	std::cout << "\t 2 - See all the dogs of a given breed, having an age less than a given number." << endl;
	std::cout << "\t 3 - See adoption list." << std::endl;
	std::cout << "\t 4 - See the adoption list file." << std::endl;
	std::cout << "\t 0 - Back to the main menu." << std::endl;
}

void UI::addDogToRepo()
{
	std::string breed;
	std::string name;
	std::string age_string;
	std::string photo;
	int age;
	while (true)
	{
		try {
			std::cout << "Enter the breed: "<<std::endl;
			getline(std::cin, breed);
			this->validator.validBreed(breed);
			break;
		}
		catch (ValidatorException& ex) {
			std::cout << ex.what() << std::endl;
		}
	}
	while (true) {
		try {
			std::cout << " Enter the name: ";
			getline(std::cin, name);
			this->validator.validName(name);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	
	while (true) {
		try {
			std::cout << " Enter the age:";
			getline(std::cin, age_string);
			this->validator.validAgeStr(age_string);
			age = stoi(age_string);
			this->validator.validAge(age);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	while (true) {
		try {
			std::cout << " Enter photo link:";
			getline(std::cin, photo);
			this->validator.validPhoto(photo);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	this->controller.addController(breed, name, age, photo);
	std::cout << "\t Added succesfully! ";
}

void UI::removeDogFromRepo()
{
	std::string breed;
	std::string name;
	while (true)
	{
		try {
			std::cout << "Enter the breed: " << std::endl;
			getline(std::cin, breed);
			this->validator.validBreed(breed);
			break;
		}
		catch (ValidatorException& ex) {
			std::cout << ex.what() << std::endl;
		}
	}
	while (true) {
		try {
			std::cout << " Enter the name: ";
			getline(std::cin, name);
			this->validator.validName(name);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	this->controller.removeController(breed, name);
	std::cout << "Removed successfully!"<<std::endl;
}

void UI::updateDogRepo()
{
	std::string old_breed;
	std::string old_name;
	std::string new_breed;
	std::string new_name;
	std::string new_age_string;
	std::string new_photo;
	int age;

	while (true)
	{
		try {
			std::cout << "Enter the breed: " << std::endl;
			getline(std::cin, old_breed);
			this->validator.validBreed(old_breed);
			break;
		}
		catch (ValidatorException& ex) {
			std::cout << ex.what() << std::endl;
		}
	}
	while (true) {
		try {
			std::cout << " Enter the name: ";
			getline(std::cin, old_name);
			this->validator.validName(old_name);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	while (true)
	{
		try {
			std::cout << "Enter the breed: " << std::endl;
			getline(std::cin, new_breed);
			this->validator.validBreed(new_breed);
			break;
		}
		catch (ValidatorException& ex) {
			std::cout << ex.what() << std::endl;
		}
	}
	while (true) {
		try {
			std::cout << " Enter the name: ";
			getline(std::cin, new_name);
			this->validator.validName(new_name);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}

	while (true) {
		try {
			std::cout << " Enter the age:";
			getline(std::cin, new_age_string);
			this->validator.validAgeStr(new_age_string);
			age = stoi(new_age_string);
			this->validator.validAge(age);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	while (true) {
		try {
			std::cout << " Enter photo link:";
			getline(std::cin, new_photo);
			this->validator.validPhoto(new_photo);
			break;
		}
		catch (ValidatorException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	this->controller.updateController(old_breed, old_name, new_breed, new_name, age, new_photo);
	std::cout << "Updated successfully!"<<std::endl;
}

void UI::listAll()
{
	std::vector <Dog> listOfDogs;
	listOfDogs = this->controller.getAllController();
	int i=0;
	for (const Dog& dog : listOfDogs) {
		std::cout << i + 1 << ". " << dog.convert() << std::endl;
		i++;
	}
}

void UI::listDogsOneByOne()
{
	std::string option;
	int current_position = 0;
	unsigned int length = this->controller.getNrElemsController();
	while (true)
	{
		if (length == 0) {
			std::string errors;
			errors += std::string("There are no more dogs");
			if (!errors.empty())
				throw RepositoryException(errors);
		}
		if (current_position == length)
			current_position = 0;
		std::cout << this->controller.getAllController()[current_position].convert() << std::endl;
		std::cout << "Adopt? [Yes / No / Exit]" << std::endl;
		std::string link = std::string("start ").append(this->controller.getAllController()[current_position].get_photograph());
		system(link.c_str());
		getline(std::cin, option);
		if (option == "Yes") {
			Dog current_dog = this->controller.getAllController()[current_position];
			this->usercontroller.addUserController(current_dog);
			length = this->controller.getNrElemsController();
		}
		else if (option == "No")
			current_position++;
		else if (option == "Exit")
			break;
		if (length == 0)
			break;


	}
}

void UI::listFilteredDogs()
{
	std::string given_breed;
	std::string given_age_string;
	int given_age;
	std::cout << "Enter the breed: ";
	getline(std::cin, given_breed);
	if (!this->validator.validString(given_breed))
	{
		std::string errors;
		errors += std::string(" Breed not valid! ");
		if (!errors.empty())
			throw ValidatorException(errors);
	}
	std::cout << "Enter the age: " << std::endl;
	getline(std::cin, given_age_string);
	this->validator.validAgeStr(given_age_string);
	given_age = stoi(given_age_string);
	this->validator.validAge(given_age);
	std::vector<Dog> filteredDogs;
	filteredDogs.reserve(this->controller.getNrElemsController());
	this->controller.getFilteredDogs(filteredDogs, given_breed, given_age);
	if (filteredDogs.empty()) {
		std::string errors;
		errors += std::string("There are no dogs! ");
		if (!errors.empty())
			throw UserException(errors);
	}
	std::string option;
	int i = 0;
	while (true) {
		if (filteredDogs.empty()) {
			std::string errors;
			errors += std::string("The list of valid dogs is empty!");
			if (!errors.empty())
				throw UserException(errors);
		}
		if (i == filteredDogs.size())
			i = 0;
		std::cout << filteredDogs[i].convert() << std::endl;
		std::cout << "Adopt? [Yes / No / Exit]" << std::endl;
		std::string link = std::string("start ").append(filteredDogs[i].get_photograph());
		system(link.c_str());
		getline(std::cin, option);
		if (option == "Yes") {
			Dog dog = filteredDogs[i];
			this->usercontroller.addUserController(dog);
			filteredDogs.erase(filteredDogs.begin() + i);
		}
		else if (option == "No") {
			i++;
		}
		else if (option == "Exit") 
			break;
		else
			std::cout << "The input is invalid!" << std::endl;
		
	}
}

void UI::listAdoptionList()
{
	int i = 0;
	std::vector<Dog> adoptionList = this->usercontroller.getAllUserController();
	for (const Dog& dog : adoptionList) {
		std::cout << i + 1 << " . " << dog.convert() << std::endl;
		i++;
	}
}

void UI::openFile()
{
	std::string link = std::string("start ").append(this->usercontroller.getFileController());
	system(link.c_str());
}

void UI::administratorMode()
{
	cout << "~This is the administrator mode.~" << endl;
	while (true) {
		try {
			printRepositoryMenu();
			std::string given_option;
			cout << "Enter the command:";
			getline(std::cin, given_option);
			if (given_option == "0")
				break;
			else if (given_option == "1")
				this->addDogToRepo();
			//break;
			else if (given_option == "2")
				this->listAll();
			//break;
			else if (given_option == "3")
				this->removeDogFromRepo();
			//break;
			else if (given_option == "4")
				this->updateDogRepo();
			//break;
			else
				std::cout << "Invalid input!" << std::endl;
		}
		catch (ValidatorException& ex) {
			std::cout << ex.what() << std::endl;
		}
		catch (RepositoryException& exc) {
			std::cout << exc.what();
			std::cout << std::endl;
		}
	}
}

void UI::userMode()
{
	std::cout << "~This is user mode.~" << endl;
	while (true) {
		try {
			printAdoptionListMenu();
			std::string option;
			std::cout << "Enter the option:";
			getline(cin, option);
			if (option == "0")
				break;
			else if (option == "1")
				this->listDogsOneByOne();
			else if (option == "2")
				this->listFilteredDogs();
			else if (option == "3")
				this->listAdoptionList();
			else if (option == "4")
				this->openFile();
			else std::cout << "Invalid input!" << std::endl;

		}
		catch (ValidatorException& ex) {
			std::cout << ex.what() << std::endl;
		}
		catch (UserException& exc) {
			std::cout<< exc.what();
			std::cout << std::endl;
		}
		catch (RepositoryException& exc) {
			std::cout << exc.what() << std::endl;
		}
	}
	
}

void UI::run()
{
	int mode = 0;
	while (true)
	{
		UI::printMenu();
		std::string command;
		std::cout << "Input the command: ";
		getline(std::cin, command);
		if (command == "0")
			break;
		else if (command == "1")
			administratorMode();
		else if (command == "2")
		{
			if (mode == 0) {
				std::cout << "Enter the type of the file in which you want to save the adoption list(csv or html):" << std::endl;
				std::string fileType;
				while (true) {
					try {
						getline(std::cin, fileType);
						this->usercontroller.repositoryType(fileType);
						break;
					}
					catch (UserException& ex) {
						std::cout << ex.what() << std::endl;
					}
				}
				mode = 1;
			}
			userMode();
		}
		else
			std::cout << "Invalid input" << std::endl;

	}
}

UI::~UI() = default;
