
#pragma once
#include <string>

class Dog {
private:
	std::string breed;
	std::string name;
	int age;
	std::string photograph;
public:
	explicit Dog(std::string breed = "empty", std::string name = "empty", int age = 0, std::string photograph = "empty");
	std::string get_breed() const;
	std::string get_name() const;
	int get_age() const;
	std::string get_photograph() const;
	~Dog();

	std::string convert() const;
	bool operator==(const Dog& dog_to_check) const;
	friend std::istream& operator>>(std::istream& inputStream, Dog& dog);
	friend std::ostream& operator<<(std::ostream& outputStream, const Dog& dogOutput);

};