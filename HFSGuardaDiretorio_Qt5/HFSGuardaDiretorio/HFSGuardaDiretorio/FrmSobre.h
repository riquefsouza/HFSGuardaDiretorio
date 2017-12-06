#ifndef FRMSOBRE_H
#define FRMSOBRE_H

#include <QDialog>

namespace Ui {
class FrmSobre;
}

class FrmSobre : public QDialog
{
    Q_OBJECT

public:
    explicit FrmSobre(QWidget *parent = 0);
    ~FrmSobre();

private:
    Ui::FrmSobre *ui;
};

#endif // FRMSOBRE_H
