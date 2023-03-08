#include "Validators.h"

Validator::Validator() = default;

bool Validator::validString(const std::string& given_string)
{
	for (char i : given_string)
		if (isdigit(i) != false)
			return false;
	return true;
}

void Validator::validBreed(const std::string& given_breed)
{
	std::string error;
	if (!validString(given_breed))
		error += std::string("The breed is not valid.");
	if (given_breed.length() == 0)
		error += std::string("There was no breed added!");
	if (!error.empty())
		throw ValidatorException(error);
}

void Validator::validName(const std::string given_name)
{
	std::string errors;
	if (!validString(given_name))
		errors += std::string("The name is invalid!");
	if (given_name.length() == 0)
		errors += std::string("There was no name added!");
	if (!isupper(given_name[0]))
		errors += std::string("The first letter must be a capital one!");
	if (!errors.empty())
		throw ValidatorException(errors);
}

void Validator::validAgeStr(const std::string& given_age)
{
	std::string errors;
	if (given_age.empty())
		errors += std::string("There is no age added!");
	if (given_age.find_first_not_of("0123456789") != std::string::npos)
		errors += std::string("The inserted age has no digits!");
	if (!errors.empty())
		throw ValidatorException(errors);
}

void Validator::validAge(int given_age)
{
	std::string errors;
	if (given_age < 0)
		errors += std::string("The age cannot be less than 0!");
	if (!errors.empty())
		throw ValidatorException(errors);
}

void Validator::validPhoto(const std::string& given_photo)
{
	std::string errors;
	if (given_photo.empty())
		errors += std::string("There was no photo added!");
	if (given_photo.find("www") == std::string::npos)
		errors += std::string("The link is not valid!");
	if (!errors.empty())
		throw ValidatorException(errors);
}

Validator::~Validator() = default;

ValidatorException::ValidatorException(std::string& message):message(message){}

const char* ValidatorException::what() const noexcept
{
	return message.c_str();
}
