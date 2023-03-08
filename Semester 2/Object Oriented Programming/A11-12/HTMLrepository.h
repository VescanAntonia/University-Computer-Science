#pragma once
#include "userrepository.h"

class HTMLRepo : public UserRepository {
public:
    HTMLRepo(const std::vector<Dog>& adoptionList, const std::string& userFilename);

    std::vector<Dog>& getAllUserRepo() override;

    unsigned int getNrElems() override;

    unsigned int getCap() override;

    void addUserRepo(const Dog& dog) override;

    void writeToFile() override;

    std::string& getFilename() override;

    ~HTMLRepo();
};