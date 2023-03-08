#pragma once
#include "Repository.h"
#include "ProgrammerRepo.h"
#include "Subject.h"

class Service :public Subject {
private:
	Repository& repo;
public:
	Service(Repository& repo1):repo{repo1}{};
	std::vector<SourceFile> getByFilename();
	void add(const std::string& name1, const std::string& status1, const std::string& creator1, const std::string& reviewer1);
};