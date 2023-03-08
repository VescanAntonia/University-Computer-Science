#pragma once
#include <vector>
#include "Domain.h"

class Repository {
private:
	std::vector<Dog> adminRepoVector;
	std::string dogsFilename;
public:
	void loadDogsFromFile();
	void writeDogToFile();
	explicit Repository(std::vector<Dog>& repo_vector, std::string& dog_filename);
	void intiRepo();
	std::vector<Dog>& getAllRepo();
	unsigned int getNrElems();
	unsigned int getCapacity();
	void addRepo(const Dog& dog);
	int finddPosByBreedAndName(const std::string& breed, const std::string& name);
	void removeRepo(int removeIndex);
	void updateRepo(int update_index, const Dog& new_dog_data);
	~Repository();
};
class RepositoryException : public std::exception {
private:
	std::string message;
public:
	explicit RepositoryException(std::string& message);
	const char* what() const noexcept override;

};