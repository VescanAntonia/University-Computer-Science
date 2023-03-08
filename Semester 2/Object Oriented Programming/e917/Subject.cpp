#include "Subject.h"

void Subject::addObserver(Observer* obs)
{
	this->repo.push_back(obs);
}

void Subject::removeObserver(Observer* obs)
{
	for (int i = 0; i < this->repo.size(); i++)
	{
		if (obs == this->repo[i]) {
			this->repo.erase(this->repo.begin() + i);
		}
	}
}

void Subject::notify()
{
	for (auto it : this->repo)
		it->update();
}
