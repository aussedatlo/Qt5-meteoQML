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


    Config {id: config}

    Text {
        id: someTxt
        text: config.msg0
        anchors.centerIn: parent
    }

    Connections
    {
        id:cppConnection
        target:meteoManager
        ignoreUnknownSignals: true
        onUpdateBigSection: {
              config.msg0 = "blabla"
       }
    }

    /*
    // Some interaction elements
    Text {
        id: someTxt
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    Button {
        id: someBtn
        text: qsTr("someButton")
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        onClicked: {
            // Default button signal
            testObject.someSlot("fn-call")
        }
    }

    // Create connections with c++
    Connections             // Define actions for custom slots
    {
        id:cppConnection
        target:testObject
        ignoreUnknownSignals: true
        onSomeSignal: {
              // To access signal parameter, name the parameter
              someTxt.text = text
       }
    }*/
}
