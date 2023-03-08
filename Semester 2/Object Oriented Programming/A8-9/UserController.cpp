#include "UserController.h"
#include "algorithm"
#include "CSVRepo.h"
#include "HTMLRepo.h"

UserController::UserController(Repository& repository2, UserRepository* userRepository2) :repository(repository2) {
	this->userRepository = userRepository2;
}

UserController::UserController(Repository& repository2) : repository(repository2){}

std::vector<Dog> UserController::getAllUserController()
{
	if (this->userRepository->getAllUserRepo().empty()) {
		std::string error;
		error += std::string("There are no adoptions!");
		if (!error.empty())
			throw UserException(error);
	}
	return this->userRepository->getAllUserRepo();
}

unsigned int UserController::getNrElemsUserController()
{
	if (this->userRepository->getNrElems()==0) {
		std::string error;
		error += std::string("There are no adoptions!");
		if (!error.empty())
			throw UserException(error);
	}
	return this->userRepository->getNrElems();
}

unsigned int UserController::getCapUserController()
{
	return this->userRepository->getCapacity();
}

void UserController::addUserController(const Dog& dog)
{
	this->userRepository->addUserRepo(dog);
	std::string breed = dog.get_breed();
	std::string name = dog.get_name();
	int removedIndex = this->repository.finddPosByBreedAndName(breed, name);
	this->repository.removeRepo(removedIndex);
}

void UserController::repositoryType(const std::string& fileType)
{
	if (fileType == "csv") {
		std::vector<Dog> vector;
		std::string userFile = R"(C:\Users\anton\source\repos\a8-9-VescanAntonia\AdoptionList.csv)";
		auto* repo = new CSVRepo{ vector, userFile };
		this->userRepository = repo;
	}
	else if (fileType == "html") {
		std::vector<Dog> vector;
		std::string userFile = R"(C:\Users\anton\source\repos\a8-9-VescanAntonia\Keep calm and adopt a pet 8-9\AdoptionList.html)";
		auto* repo = new HTMLRepo{ vector, userFile };
		this->userRepository = repo;
	}
	else {
		std::string errors;
		errors += std::string("The filename is invalid!");
		if (!errors.empty())
			throw UserException(errors);
	}
}

std::string& UserController::getFileController()
{
	return this->userRepository->getFilename();
}

UserController::~UserController() = default;
