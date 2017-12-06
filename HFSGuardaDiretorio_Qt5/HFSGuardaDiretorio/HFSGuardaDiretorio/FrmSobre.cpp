#include "FrmSobre.h"
#include "ui_FrmSobre.h"

FrmSobre::FrmSobre(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::FrmSobre)
{
    ui->setupUi(this);

    setSizePolicy(QSizePolicy::Fixed,QSizePolicy::Fixed);
    setMinimumSize(316,132);
    setMaximumSize(minimumSize());
    setWindowFlags(windowFlags() & (~Qt::WindowContextHelpButtonHint));
}

FrmSobre::~FrmSobre()
{
    delete ui;
}
