#ifndef DIRETORIOORDEM_H
#define DIRETORIOORDEM_H

#pragma once

namespace hfsguardadir {

namespace objetos {

class DiretorioOrdem
{
private:
    int ordem;

public:
    DiretorioOrdem();
    int getOrdem();
    void setOrdem(int ordem);

};

}
}

#endif // DIRETORIOORDEM_H
