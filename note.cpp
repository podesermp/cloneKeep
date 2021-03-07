#include "note.h"
#include <time.h>
#include <iostream>
#include <QDebug>

Note::Note(){

}

Note::Note(const QString &title, const QString &creator,
           const QString &content, const QString &email){

    this->title = title;

    if(this->content.length() >= 15){
        for(int i = 0; i < content.length()/4; i++){
            this->description[i] = this->content[i];
        }
    }else{
        this->description = this->content;
    }

    this->creator = creator;
    this->content = content;
    this->email = email;

    //verifica e guarda a data e hora da ultima modificação
    time_t mytime;
    mytime = time(NULL);
    QString string= ctime(&mytime);
    //Para remover o /n da string
    int i = 0;
    while(string[i] != '\n'){
        this->lastModify[i] = string[i];
        i++;
    }
    this->lastModify = ctime(&mytime);

    this->colorPreference = "#ffe66d";
}

