#pragma once
#include "domain.h"

class ValidationException : public std::exception {
private:
    std::string message;
public:
    explicit ValidationException(std::string& _message);

    const char* what() const noexcept override;
};

class DogValidator {
public:
    DogValidator();

    bool validateString(const std::string& input);

    void validateBreed(const std::string& breed);

    void validateName(const std::string& name);

    void validateAgeString(const std::string& age);

    void validateAge(int age);

    void validatePhotoLink(const std::string& photograph);

    ~DogValidator();
};