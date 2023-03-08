#pragma once
#include "UserRepo.h"

class CSVRepo :public UserRepository {
public:
	CSVRepo(const std::vector<Dog>& adoptionList, const std::string& userFilename);
	std::vector<Dog>& getAllUserRepo() override;
	unsigned int getNrElems() override;
	unsigned int getCapacity() override;
	void addUserRepo(const Dog& dog) override;
	void writeToFile() override;
	std::string& getFilename() override;
	~CSVRepo();
};