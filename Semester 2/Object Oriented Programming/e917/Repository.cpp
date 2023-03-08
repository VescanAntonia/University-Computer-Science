#include "Repository.h"
#include <fstream>

void Repository::loadData()
{
	std::ifstream f("sourcefiles.txt");
	while (!f.eof()) {
		SourceFile s;
		f >> s;
		this->data.push_back(s);
	}
	f.close();
}

void Repository::saveData()
{
	std::ofstream f("sourcefiles.txt");
	for (int i = 0; i < this->data.size() - 1; ++i)
	{
		f << this->data[i]<<"\n";
	}
	f << this->data[this->data.size() - 1];
	f.close();
}

void Repository::add(SourceFile s)
{
	this->data.push_back(s);
}
