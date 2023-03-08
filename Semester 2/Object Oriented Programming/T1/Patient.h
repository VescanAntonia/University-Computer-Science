#pragma once
#include <string>
using namespace std;


class Patient
{
public:
	Patient(string name, int age, bool infected, int room, bool quarantined);
	Patient();
private:
	string name;
	int age;
	bool infected;
	int room;
	bool quarantined;

public:
	string get_name()const;
	int get_age()const;
	bool get_infected()const;
	int get_room()const;
	bool get_quarantined()const;
	string convert()const;

};