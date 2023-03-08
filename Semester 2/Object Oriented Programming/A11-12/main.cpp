#include "GUI.h"
#include <QtWidgets/QApplication>
#include "validator.h"
#include "service.h"
#include "userservice.h"
#include "repository.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    std::vector<Dog> adminRepoVector;
    adminRepoVector.reserve(10);
    std::string filename = R"(C:\Users\anton\source\repos\a11-12-VescanAntonia\GUI\dogs.txt)";
    Repository repo{ adminRepoVector, filename };
    repo.initialiseRepo();
    Service service{ repo };
    UserService userService{ repo };
    DogValidator validator{};
    GUI gui{ service, userService, validator, repo };
    gui.show();
    return a.exec();
}
