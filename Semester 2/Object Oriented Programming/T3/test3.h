#pragma once
#include "Service.h"
#include <QtWidgets/QWidget>
#include "ui_test3.h"

class test3 : public QWidget
{
    Q_OBJECT

public:
    test3(Service &serv1,QWidget *parent = Q_NULLPTR);

private:
    Service& serv;
    Ui::test3Class ui;
    void populateList();
};
