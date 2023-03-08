#include "UI.h"
#include "Controller.h"
#include <Windows.h>
#include "TestDomain.h"
#include "TestDynVector.h"
#include "TestRepo.h"
#include "TestController.h"
#include "TestUserRepo.h"
#include "TestUserController.h"
#include <crtdbg.h>

using namespace std;

void testAll() {
	testDomain();
	testDynVector();
	testRepository();
	testController();
	testUserRepo();
	testUserController();
}
int main()
{
	{
		testAll();
		auto* dynamicvector = new DynamicVector<Dog>(10);
		auto repo = new Repository(dynamicvector);
		repo->init_repo();
		auto dynamicvector1 = new DynamicVector<Dog>(10);
		auto* userrepo = new UserRepository(dynamicvector1);
		auto* controller = new Controller(repo);
		auto* usercontroller = new UserController(repo, userrepo);
		auto* ui = new UI(controller, usercontroller);
		ui->run();



		//UserRepository userRepo{};
		//Repository repo2{};
		//UserController usercontroller{ repo2, userRepo };
		//controller.addDogRepository("Labrador", "Lena", 15, "www.strabsnjm");
		//controller.addDogRepository("Husky", "Elena", 5, "www.dldd");
		//controller->testsController();
		//UI ui{ controller };
		//UI ui{controller, usercontroller};
		//ui.run();

	}
	//_CrtDumpMemoryLeaks();
	//system("color f4");
	return 0;
}