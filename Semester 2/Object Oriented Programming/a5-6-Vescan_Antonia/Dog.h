#pragma once
#include <iostream>
#include <cstring>
#include <string>

using namespace std;


class Dog 
{
private:
	string breed;
	string name;
	int age;
	string photograph;

public:
	/// <summary>
	/// constructor for the dog
	/// </summary>
	/// <param name="breed"></param>
	/// <param name="name"></param>
	/// <param name="age"></param>
	/// <param name="photograph"></param>
	Dog(string breed = "empty", string name = "empty", int age=0, string photograph="empty");

	/// <summary>
	/// getter for the breed
	/// </summary>
	/// <returns></returns>
	string get_breed() const;
	/// <summary>
	/// getter for the name
	/// </summary>
	/// <returns></returns>
	string get_name() const;
	/// <summary>
	/// getter for the age
	/// </summary>
	/// <returns></returns>
	int get_age() const;
	/// <summary>
	/// getter for the photograph
	/// </summary>
	/// <returns></returns>
	string get_photograph() const;
	
	/// <summary>
	/// setter for the breed
	/// </summary>
	/// <param name="breed"></param>
	void set_breed(string breed);
	/// <summary>
	/// setter for the name
	/// </summary>
	/// <param name="name"></param>
	void set_name(string name);
	/// <summary>
	/// setter for the age
	/// </summary>
	/// <param name="age"></param>
	void set_age(int age);
	/// <summary>
	/// setter for the photograph
	/// </summary>
	/// <param name="photograph"></param>
	void set_photograph(string photograph);
	/// <summary>
	/// converts the given dog to a string to be printed
	/// </summary>
	/// <returns></returns>
	string convert();
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~Dog();
};
