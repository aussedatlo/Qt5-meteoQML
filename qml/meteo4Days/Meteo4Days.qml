import QtQuick 2.3
import QtQuick.Controls 1.2

Item {
    id: aw
    visible: true
    width: 320
    height: 240

    MouseArea {
            anchors.fill: rect1
            onClicked: {
                meteoManager.updateTarget(2);
                main.changeView("../meteo1Day/Meteo1Day.qml");
                meteoManager.updateData();
            }
        }

    Rectangle {
        id: rect1
        width: aw.width/2
        height: aw.height

        BigSection {
            id: bigSection
        }
    }

    Rectangle {
        id: rect2
        width: aw.width/2
        height: aw.height
        anchors.left: rect1.right;

        SmallSection {
            id: smallSection1
        }

        SmallSection {
            id: smallSection2
            anchors.top: smallSection1.bottom
        }

        SmallSection {
            id: smallSection3
            anchors.top: smallSection2.bottom
        }
    }

    Connections
    {
        target:meteoManager
        ignoreUnknownSignals: true
        onUpdateBigSection: {
            bigSection.temp_max = temp_max
            bigSection.temp_min = temp_min
            bigSection.icon = icon
       }
        onUpdateSmallSection: {
            if (index == 1) {
                smallSection1.temp_min = temp_min
                smallSection1.temp_max = temp_max
                smallSection1.icon = icon
            }
            if (index == 2) {
                smallSection2.temp_min = temp_min
                smallSection2.temp_max = temp_max
                smallSection2.icon = icon
            }
            if (index == 3) {
                smallSection3.temp_min = temp_min
                smallSection3.temp_max = temp_max
                smallSection3.icon = icon
            }
       }
    }
}
