import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id: aw
    visible: true
    width: 320
    height: 240
    title: qsTr("Hello World")

    property string max_big: "36"
    property string min_big: "18"

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
            property string temp_min: ""
            property string temp_max: ""
        }

        SmallSection {
            id: smallSection2
            anchors.top: smallSection1.bottom
            property string temp_min: ""
            property string temp_max: ""
        }

        SmallSection {
            id: smallSection3
            anchors.top: smallSection2.bottom
            property string temp_min: ""
            property string temp_max: ""
        }
    }


    Config {id: config}

    Connections
    {
        id:cppConnection
        target:meteoManager
        ignoreUnknownSignals: true
        onUpdateBigSection: {
            config.temp_max = temp_max
            config.temp_min = temp_min
            config.icon = icon
       }
        onUpdateSmallSection: {
            console.log("smallSection")
            if (index == 1) {
                smallSection1.temp_min = temp_min
                smallSection1.temp_max = temp_max
            }
            if (index == 2) {
                smallSection2.temp_min = temp_min
                smallSection2.temp_max = temp_max
            }
            if (index == 3) {
                smallSection3.temp_min = temp_min
                smallSection3.temp_max = temp_max
            }
       }
    }
}
