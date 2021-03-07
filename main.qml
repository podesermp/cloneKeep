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
    title: qsTr("Note Teste")
    color: "#fafafa"


    ConfirmaAcao {
        id: confirmaAcao
        onAccepted: {
            dbNotes.deleteRow(nota.id)
        }
    }
    Dialog{
        id: addNoteDialog
        x: parent.width/2 - addNoteDialog.width/2
        y: parent.height/2 - addNoteDialog.height/2
        height: parent.width/2
        width: parent.height
        title: "Nova nota"
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
                        dbNotes.newRow(titleField.text, creatorField.text, contentField.text, emailField.text)
                        addNoteDialog.clearFields()
                        addNoteDialog.close()
                    }
                }
            }
        }
    }
    NoteDatabaseModel{
        id: dbNotes
    }

    ListView{
        anchors.fill: parent
        spacing: 8
        header: Card{
            height: 200
            width: parent.width
            Text{
                anchors.fill: parent
                text: "Bloco de notas"
                color: "#234780"
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
                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 8
                    source: "qrc:/icons/addNote.png"
                }
                onPressed:{
                    addNoteDialog.open();
                }
            }
        }
        model: dbNotes
        delegate: Card{
            id: cardNote
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
                        text: model.content
                        font.pixelSize: 15
                        wrapMode: Text.WordWrap
                    }
                    ColumnLayout{
                        Text{
                            anchors.left: parent.left
                            Layout.fillWidth: true
                            color: "black"
                            text: model.creator
                            font.pixelSize: 10
                            wrapMode: Text.WordWrap
                        }
                        Text{
                            anchors.left: parent.left
                            Layout.fillWidth: true
                            color: "black"
                            text: model.lastModify
                            font.pixelSize: 10
                            wrapMode: Text.WordWrap
                        }
                    }
                }
                Button{
                    Image {
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        anchors.margins: 8
                        source: "qrc:/icons/delete.png"
                    }
                    onPressed:{
                        confirmaAcao.nota = {
                            title: model.title,
                            id: model.id,
                            colorPreference: model.colorPreference
                        }
                        confirmaAcao.open()
                    }
                }
            }
        }
    }
}

