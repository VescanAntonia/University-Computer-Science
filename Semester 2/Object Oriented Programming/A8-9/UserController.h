#pragma once
#include "Repository.h"
#include "UserRepo.h"

class UserController {
private:
	Repository& repository;
	UserRepository* userRepository;
public:
	UserController(Repository& repository1, UserRepository* userRepository1);
	explicit UserController(Repository& repository1);
	std::vector<Dog> getAllUserController();
	unsigned int getNrElemsUserController();
	unsigned int getCapUserController();
	void addUserController(const Dog& dog);
	void repositoryType(const std::string& fileType);
	std::string& getFileController();
	~UserController();
};