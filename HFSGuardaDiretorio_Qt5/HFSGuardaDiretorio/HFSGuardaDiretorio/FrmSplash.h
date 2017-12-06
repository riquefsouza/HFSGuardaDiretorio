#ifndef FRMSPLASH_H
#define FRMSPLASH_H

#include <QDialog>
#include "hfsguardadir/comum/Rotinas.h"

using namespace hfsguardadir::comum;

namespace Ui {
class FrmSplash;
}

class FrmSplash : public QDialog
{
    Q_OBJECT

public:
    explicit FrmSplash(QWidget *parent = 0);
    ~FrmSplash();

	static void ProgressoLog(Progresso progresso);

private:
    Ui::FrmSplash *ui;

private slots:
	void progressBarUpdated(int value);

};

extern FrmSplash *frmSplash;

#endif // FRMSPLASH_H
