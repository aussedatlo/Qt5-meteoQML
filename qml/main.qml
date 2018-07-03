import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id: aw
    visible: true
    width: 320
    height: 240
    title: qsTr("Hello World")
    Rectangle {
        id: rect1
        width: aw.width/2
        height: aw.height

        Rectangle {
            width: parent.width
            height: 2*parent.height/3
            border.color: "black"
            border.width: 1
            anchors.top: parent.top
            Image {
                id: root
                source: "/meteo/03d"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 10
                scale:0.23
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height/3
            border.color: "black"
            border.width: 1
            anchors.bottom: parent.bottom


            Text {
                id: temp1
                text: "20"
                font.family: "Helvetica"
                font.pointSize: 24
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: temp2
                text: "12"
                font.family: "Helvetica"
                font.pointSize: 24
                color: "blue"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: temp1.bottom
            }
        }


    }

    Rectangle {
        id: rect2
        width: aw.width/2
        height: aw.height
        color: "blue"
        border.color: "black"
        border.width: 1
        anchors.left: rect1.right;
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
