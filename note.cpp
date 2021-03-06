#include "note.h"
#include <time.h>
#include <iostream>

Note::Note(){

}

Note::Note(const QString &title, const QString &creator,
           const QString &content, const QString &email){

    this->title = title;


    //Pega so uma parte do conteudo completo
//    for(int i = 0; i < 15; i++){
//        this->description[i] = content[i];
//    }

    this->creator = creator;
    this->content = content;
    this->email = email;

    //verifica e guarda a hora da ultima modificação
    time_t mytime;
    mytime = time(NULL);
    this->date = ctime(&mytime);

    this->colorPreference = "#ccd5ae";
}

