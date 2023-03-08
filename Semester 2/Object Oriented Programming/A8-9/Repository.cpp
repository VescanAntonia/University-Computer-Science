#include "Repository.h"
#include <algorithm>
#include <fstream>
#include <cstring>
#include <iostream>
using namespace std;

void Repository::loadDogsFromFile()
{
    if (!this->dogsFilename.empty())
    {
        Dog dogFromFile;
        std::ifstream fin(this->dogsFilename);
        while (fin >> dogFromFile) {
            if (std::find(this->adminRepoVector.begin(), this->adminRepoVector.end(), dogFromFile) == this->adminRepoVector.end())
                this->adminRepoVector.push_back(dogFromFile);
        }
        fin.close();
    }
}

void Repository::writeDogToFile()
{
    if (!this->dogsFilename.empty()) {
        std::ofstream fout(this->dogsFilename);
        for (const Dog& dog : this->adminRepoVector) {
            fout << dog << "\n";

        }
        fout.close();
    }
}

Repository::Repository(std::vector<Dog>& repo_vector, std::string& dog_filename)
{
    this->adminRepoVector = repo_vector;
    this->dogsFilename = dog_filename;
}

void Repository::intiRepo()
{
    this->loadDogsFromFile();
}

std::vector<Dog>& Repository::getAllRepo()
{
    if (this->adminRepoVector.empty()) {
        std::string error;
        error += std::string(" There are no dogs!");
        if (!error.empty())
            throw RepositoryException(error);

    }
    return this->adminRepoVector;
}

unsigned int Repository::getNrElems()
{
    if (this->adminRepoVector.empty()) {
        std::string error;
        error += std::string("There are no dogs!");
        if (!error.empty())
            throw RepositoryException(error);
    }
    return this->adminRepoVector.size();
}

unsigned int Repository::getCapacity()
{
    return this->adminRepoVector.capacity();
}

void Repository::addRepo(const Dog& dog)
{
    int already_exists = this->finddPosByBreedAndName(dog.get_breed(), dog.get_name());
    if (already_exists != -1)
    {
        std::string error;
        error += std::string("The dog is already in the list!");
        if (!error.empty())
            throw RepositoryException(error);

    }
    this->adminRepoVector.push_back(dog);
    this->writeDogToFile();
}

int Repository::finddPosByBreedAndName(const std::string& breed, const std::string& name)
{
    int position = -1;
    std::vector<Dog>::iterator it;
    it = std::find_if(this->adminRepoVector.begin(), this->adminRepoVector.end(), [&breed,&name](Dog& dog) {return dog.get_breed() == breed && dog.get_name() == name; });
    if (it != this->adminRepoVector.end())
    {
        position = it - this->adminRepoVector.begin();
    }
    return position;
}

void Repository::removeRepo(int removeIndex)
{
    if (removeIndex==-1)
    {
        std::string error;
        error += std::string("The dog does not exist!");
        if (!error.empty())
            throw RepositoryException(error);

    }
    this->adminRepoVector.erase(this->adminRepoVector.begin() + removeIndex);
    this->writeDogToFile();
}

void Repository::updateRepo(int update_index, const Dog& new_dog_data)
{
    if (update_index==-1)
    {
        std::string error;
        error += std::string("The dog does not exist!");
        if (!error.empty())
            throw RepositoryException(error);
    }
    this->adminRepoVector[update_index] = new_dog_data;
    this->writeDogToFile();
}

Repository::~Repository() = default;

RepositoryException::RepositoryException(std::string& message) : message(message){}

const char* RepositoryException::what() const noexcept
{
    return message.c_str();
}
