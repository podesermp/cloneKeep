import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Models 1.0



Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Note Klone")
    color: "#fafafa"

    ConfirmaAcao {
        id: confirmaAcao
        onAccepted: {
            notes.deleteNote(note.index)
        }
    }

    Dialog{

        id: addNoteDialog
        x: parent.width/2 - addNoteDialog.width/2
        y: parent.height/2 - addNoteDialog.height/2
        height: parent.width/2
        width: parent.height

        function clearFields(){
            titleField.clear();
            contentField.clear();
            creatorField.clear();
            emailField.clear();
        }

        ColumnLayout{
            spacing: 15
            width: parent.height
            height: parent.width/2
            ColumnLayout{
                TextField{
                    id: titleField
                    placeholderText: "Título"
                }
                TextField{

                    id: contentField
                    placeholderText: "Nota"
                }
            }
            RowLayout{
                TextField{
                    id: creatorField
                    placeholderText: "Criador"
                }
                TextField{
                    id: emailField
                    placeholderText: "Email"
                    validator: RegExpValidator{regExp: /[a-z 0-9]*@[a-z]*.[a-z]*/}
                }
            }
            RowLayout{
                Button{
                    text: "Cancelar"
                    flat: true
                    Material.foreground: "#C62828"
                    onPressed: {
                        addNoteDialog.clearFields()
                        addNoteDialog.close()
                    }
                }
                Button{
                    text: "Salvar"
                    flat: true
                    Material.foreground: "#146D99"
                    enabled: !titleField.text == "" && !creatorField.text == "" && !emailField.text == ""
                    onPressed: {
                        notes.insertNote(titleField.text, creatorField.text, contentField.text, emailField.text)
                        addNoteDialog.clearFields()
                        addNoteDialog.close()
                    }
                }
            }
        }
    }

    Dialog{
        id: opcoesDialog

        x: parent.width/2 - addNoteDialog.width/2
        y: parent.height/2 - addNoteDialog.height/2

        standardButtons: Dialog.Ok | Dialog.Cancel
        GridLayout{
            columns: 3
            rows: 3
            Button{
                text:"azulzim"
                onPressed: {
                    notes.ColorPreference = "#8ecae6"
                    print(notes.ColorPreference)
                }
            }
            Button{
                text:"verdim"
            }
            Button{
                text:"amarelo"
                onPressed: {
                    notes.ColorPreference = "#ccd5ae"
                    print(notes.ColorPreference)
                }
            }
            Button{
                text:"marromzim"
                onPressed: {
                    notes.ColorPreference = "#e09f3e"
                    print(notes.ColorPreference)
                }
            }
            Button{
                text:"laranja"
                onPressed: {
                    notes.ColorPreference = "#ff7b00"
                    print(notes.ColorPreference)
                }
            }
            Button{
                text:"lilas"
                onPressed: {
                    notes.ColorPreference = "#c77dff"
                    print(notes.ColorPreference)
                }
            }
        }
    }

    NoteListModel{
        id: notes
        Component.onCompleted:{
            //            notes.addNotes()
            //notes.insertNote("teste", "teste", "teste", "teste", "teste", "teste", "#E2D4B7")
        }
    }

    ListView{
        anchors.fill: parent
        spacing: 8
        header: Rectangle{
            color: "#234780"
            height: 200
            width: parent.width
            Text{
                anchors.fill: parent
                text: "Bloco de notas"
                color: "white"
                font.pixelSize: 50
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
            }
            Button{
                anchors{
                    bottom: parent.bottom
                    right: parent.right
                    rightMargin: 16
                    bottomMargin: 16
                }
                text: "+Nota"
                onPressed:{
                    addNoteDialog.open();
                }
            }
        }
        model: notes
        delegate: Card{
            height: 100
            width: parent.width
            RowLayout{
                anchors.fill: parent
                anchors.leftMargin: 24
                anchors.rightMargin: 24
                ColumnLayout{
                    Text{
                        Layout.fillWidth: true
                        anchors{
                            fill: parent
                            top: parent.top
                            left: parent.left
                        }
                        color: "black"
                        text: model.title
                        wrapMode: Text.WordWrap
                        font{
                            pixelSize: 25
                            bold: true
                        }
                    }
                    Text{
                        anchors.left: parent.left
                        Layout.fillWidth: true
                        color: "black"
                        text: model.description
                        font.pixelSize: 15
                        wrapMode: Text.WordWrap
                    }
                    RowLayout{
                        Text{
                            anchors{
                                left: parent.left
                                bottom: parent.bottom
                            }
                            Layout.fillWidth: true
                            color: "black"
                            text: model.date
                            font.pixelSize: 8
                            font.italic: true
                            wrapMode: Text.WordWrap
                        }
                        Text{
                            anchors{
                                bottom: parent.bottom
                                right: parent.right
                            }

                            Layout.fillWidth: true
                            color: "black"
                            text: model.creator
                            font.pixelSize: 8
                            font.italic: true
                            wrapMode: Text.WordWrap
                        }
                    }
                }
                Button{
                    text: "Cor"
                    onPressed:{
                        opcoesDialog.open()
                    }
                }

                Button{
                    text: "Modificar"
                    onPressed:{
                        print("Modificar")
                    }
                }
                Button{
                    text: "Deletar"
                    onPressed:{
                        confirmaAcao.note = {
                            title: model.title,
                            index: index
                        }
                        confirmaAcao.open()
                    }
                }
            }
        }
    }
}

