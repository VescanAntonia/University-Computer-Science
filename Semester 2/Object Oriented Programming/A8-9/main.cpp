#include <crtdbg.h>
#include "Repository.h"
#include "Controller.h"
#include "Ui.h"

int main() 
{
	{
		std::vector<Dog> adminRepositoryVector;
		adminRepositoryVector.reserve(10);
		//std::string filename = "Dogs.txt";
		//std::string filename = R"(C:\Users\anton\source\repos\a8-9-VescanAntonia\Keep calm and adopt a pet 8-9\Dogs.txt)";
		std::string filename = R"(C:\Users\anton\source\repos\a8-9-VescanAntonia\Dogs.txt)";
		Repository repo{ adminRepositoryVector, filename };
		repo.intiRepo();
		Controller controller{ repo };
		UserController usercontroller{ repo };
		Validator validator{};
		UI ui{ controller,usercontroller,validator };
		ui.run();
	}
	
	_CrtDumpMemoryLeaks();
	return 0;
}