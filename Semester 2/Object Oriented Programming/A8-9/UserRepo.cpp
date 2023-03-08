#include "UserRepo.h"
#include <fstream>

UserRepository::UserRepository(std::vector<Dog>& adoptionList1)
{
	this->adoptionList = adoptionList1;
}

UserRepository::UserRepository() = default;


UserException::UserException(std::string& message){}

const char* UserException::what() const noexcept
{
	return message.c_str();
}

UserRepository::~UserRepository() = default;