#pragma once
#include "Programmer.h"
#include "Subject.h"
#include "Service.h"
#include <QtWidgets/QMainWindow>
#include "ui_GUI.h"

class GUI : public QMainWindow, public Observer
{
    Q_OBJECT

public:
    GUI(Service& serve, Programmer& type1,QWidget *parent = Q_NULLPTR);

private:
    Ui::GUIClass ui;
    Service& serv;
    Programmer& type;
    void conncetSignalsAndSlot();
    void add();
    void update();
};
