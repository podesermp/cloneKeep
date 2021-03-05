import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Note Klone")
    color: "#fafafa"

    //colorNote guarda o hexadecimal da cor escolhida
    property string header: "#234780"
    property string colorNote: "#E9C46A"
    property var notes: [
        {title: "Nota um", content: "minhas notas um", author: "Eu", date: "15/05/2021"},
        {title: "Nota dois", content: "minhas notas dois", author: "Eu", date: "15/05/2021"},
    ]



    ListView{
        anchors.fill: parent
        model: notes
        spacing: 8
        header: Rectangle{
            color: header
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
                    print("Nova anotação")
                }
            }
        }

        delegate: Card{
            height: 100
            width: parent.width
            RowLayout{
                anchors.fill: parent
                anchors.leftMargin: 24
                anchors.rightMargin: 24

                Text{
                    Layout.fillWidth: true
                    color: "black"
                    text: modelData.title
                    wrapMode: Text.WordWrap
                    font.pixelSize: 20
                }

                Button{
                    text: "opções"
                    onPressed:{
                        print("opções")
                    }
                }

                Button{
                    text: "Ver"
                    onPressed:{
                        print("Ver")
                    }
                }
            }
        }
    }
}
