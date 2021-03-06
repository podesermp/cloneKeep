import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Models 1.0



Dialog{
    id:confirmaAcao
    x: parent.width/2 - confirmaAcao.width/2
    y: parent.height/2 - confirmaAcao.height/2
    property var note
    standardButtons: Dialog.Ok | Dialog.Cancel
    title: "Deseja realmente fazer isso?"
}
