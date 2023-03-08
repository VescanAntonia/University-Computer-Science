#pragma once
#include <string>

class SourceFile {
private:
	std::string name;
	std::string status;
	std::string creator;
	std::string reviewer;
public:
	SourceFile(){}
	SourceFile(const std::string& name1, const std::string& status1, const std::string& creator1, const std::string& reviewer1):name{name1},status{status1},creator{creator1},reviewer{reviewer1}{};
	std::string getName()const { return this->name; }
	std::string getStatus() const { return this->status; }
	std::string getCreator() const { return this->creator; }
	std::string getReviewer() const { return this->reviewer; }
	friend std::istream& operator>>(std::istream& in, SourceFile& p);
	friend std::ostream& operator<<(std::ostream& out,SourceFile& p);
};