#include "Domain.h"
#include <utility>
#include <vector>
#include <sstream>

Dog::Dog(std::string breed, std::string name, int age, std::string photograph)
{
    if (age < 0)
        throw "Age cannot be a negative number!";
    this->breed = std::move(breed);
    this->name = std::move(name);
    this->age = age;
    this->photograph = std::move(photograph);
}

std::string Dog::get_breed() const
{
    return this->breed;
}

std::string Dog::get_name() const
{
    return this->name;
}

int Dog::get_age() const
{
    return this->age;
}

std::string Dog::get_photograph() const
{
    return this->photograph;
}

Dog::~Dog() = default;

std::string Dog::convert() const
{
    auto string_age = std::to_string(this->age);
    return "Breed: " + this->breed + " | Name: " + this->name+" | Age: "+string_age+" | Photo link: "+ this->photograph;
}

bool Dog::operator==(const Dog& dog_to_check) const
{
    return this->breed == dog_to_check.breed && this->name==dog_to_check.name;
}

std::vector<std::string> split_parameters(const std::string& str, char delimiter) {
    std::vector<std::string> result;
    std::stringstream ss(str);
    std::string token;
    while (getline(ss, token, delimiter))
        result.push_back(token);

    return result;
}

std::istream& operator>>(std::istream& inputStream, Dog& dog)
{
    std::string line;
    std::getline(inputStream, line);
    std::vector<std::string> tokens;
    if (line.empty())
        return inputStream;
    tokens = split_parameters(line,',');
    dog.breed = tokens[0];
    dog.name = tokens[1];
    dog.age = std::stoi(tokens[2]);
    dog.photograph = tokens[3];
}

std::ostream& operator<<(std::ostream& outputStream, const Dog& dogOutput)
{
    outputStream << dogOutput.breed << "," << dogOutput.name << "," << std::to_string(dogOutput.age) << "," << dogOutput.photograph;
    return outputStream;
}
