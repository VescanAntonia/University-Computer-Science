#include "GUI.h"
#include <qwindow.h>
#include <qmessagebox.h>
#include <string>
#include <sstream>
using namespace std;

GUI::GUI(Service& serv1, Programmer& type1,QWidget *parent)
    : QMainWindow(parent), serv{serv1}, type{type1}
{
    ui.setupUi(this);
    this->serv.addObserver(this);
    conncetSignalsAndSlot();
    this->update();
    this->setWindowTitle(QString::fromStdString(this->type.getName()));
    std::stringstream txt2{};
    std::stringstream txt1{};
    txt1 << "Revised: "<<type.getNumberRevised();
    txt2 << "Unrivised: "<<(int(this->type.getTotalFiles()) - int(this->type.getNumberRevised()));
    this->ui.revisedlabel->setText(QString::fromStdString(txt1.str()));
    this->ui.stillToReviseLabel->setText(QString::fromStdString(txt2.str()));
}

void GUI::conncetSignalsAndSlot()
{
    QObject::connect(this->ui.pushButton, &QAbstractButton::clicked, this, &GUI::add);
}

void GUI::add()
{
    std::string name = this->ui.sourcelineEdit->text().toStdString();
    std::string status = "not_revised";
    std::string creator = this->windowTitle().toStdString();
    //std::string creator = "m";
    std::string reviewer = "None";
    try {
        this->serv.add(name, status, creator, reviewer);
        this->ui.sourcelineEdit->clear();
    }
    catch (std::exception& e) {
        QMessageBox box;
        box.setText(e.what());
        box.exec();
    }
    this->update();
}

void GUI::update()
{
    this->ui.listWidget->clear();
    for (auto it : this->serv.getByFilename()) {
        std::stringstream txt{};
        txt << "Name: " << it.getName() << " Status: " << it.getStatus() << " Creator: " << it.getCreator() << " Reviewer:" << it.getReviewer();
        //if (it.getStatus()=="not_revised")
        this->ui.listWidget->addItem(QString::fromStdString(txt.str()));
    }

}
