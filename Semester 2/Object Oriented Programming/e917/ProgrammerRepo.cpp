#include "ProgrammerRepo.h"
#include <fstream>

void ProgrammerRepo::loadData()
{
	std::ifstream f("programers.txt");
	while (!f.eof()) {
		Programmer s;
		f >> s;
		this->data.push_back(s);
	}
	f.close();
}

void ProgrammerRepo::saveData()
{
	std::ofstream f("programers.txt");
	for (int i = 0; i < this->data.size() - 1; ++i)
	{
		f << this->data[i] << "\n";
	}
	f << this->data[this->data.size() - 1];
	f.close();
}
