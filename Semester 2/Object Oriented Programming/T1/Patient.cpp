#include "Patient.h"
#include <string>

Patient::Patient(string name, int age, bool infected, int room, bool quarantined)
{
	this->name = name;
	this->age = age;
	this->infected = infected;
	this->room = room;
	this->quarantined = quarantined;

}

Patient::Patient()
{
	this->name = "";
	this->age = 0;
	this->infected = false;
	this->room = 0;
	this->quarantined = false;
}

string Patient::get_name()const
{
	return this->name;
}

int Patient::get_age()const
{
	return this->age;
}

bool Patient::get_infected()const
{
	return this->infected;
}

int Patient::get_room()const
{
	return this->room;
}

bool Patient::get_quarantined()const
{
	return this->quarantined;
}

string Patient::convert()const
{
	return "Name: "+this->name+" | Age: " + to_string(this->age)+ " | Infected: " + to_string(this->infected)+ " | Room: "+ to_string(this->room)+ " | Quarantined: "+ to_string(this->quarantined);
}
