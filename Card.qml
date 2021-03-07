import QtQuick 2.0
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material.impl 2.12

Item {
    id: cardNote
    property int elevation: 1

    Rectangle{
        anchors{
            fill:parent
            leftMargin: 8
            rightMargin: 8
        }
        color: nota.colorPreference
        radius: 4
        layer.enabled:cardNote.elevation>0
        layer.effect: ElevationEffect{
            elevation:cardNote.elevation
        }
    }
}
