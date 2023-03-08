#pragma once
#include "Domain.h"


class Validator {
public:
	Validator();
	bool validString(const std::string& given_string);
	void validBreed(const std::string& given_breed);
	void validName(const std::string given_name);
	void validAgeStr(const std::string& given_age);
	void validAge(int given_age);
	void validPhoto(const std::string& given_photo);
	~Validator();
};

class ValidatorException :public std::exception {
private:
	std::string message;
public:
	explicit ValidatorException(std::string& message);
	const char* what() const noexcept override;

};