#include "Dog.h"
#include <utility>
#include <iostream>
#include <cstring>
#include <sstream>

Dog::Dog(string breed, string name, int age, string photograph)
{
    if (age < 0) {
        throw "Age can't be smaller than 0!";
    }
    this->breed = breed;
    this->name = name;
    this->age = age;
    this->photograph = photograph;
}

//Dog::Dog()
//{
//    this->breed = "";
//    this->name = "";
//    this->age = 0;
//    this->photograph = "";
//}

string Dog::get_breed() const
{
    return this->breed;
}

string Dog::get_name() const
{
    return this->name;
}

int Dog::get_age() const
{
    return this->age;
}

string Dog::get_photograph() const
{
    return this->photograph;
}

void Dog::set_breed(string breed)
{
    this->breed = breed;
}

void Dog::set_name(string name)
{
    this->name = name;
}

void Dog::set_age(int age)
{
    this->age = age;
}

void Dog::set_photograph(string photograph)
{
    this->photograph = photograph;
}

string Dog::convert()
{
    return "Breed: " + this->breed + " |Name: " + this->name + " |Age: " + to_string(this->age) + " |Photograph: " + this->photograph;
}

Dog::~Dog() = default;
