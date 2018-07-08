import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    visible: true
    width: 320
    height: 240
    property string temp: "15"
    property string icon: "02d"
    property string humid: "32"
    property string wind: "15"
    property string rain: "8"

    MouseArea {
            anchors.fill: parent
            onClicked: {main.changeView("retour Meteo4Days.qml");}
        }

    Rectangle {
        id: rectangle_info
        width: parent.width/2
        height: parent.height/2 - 10

        Column {
            spacing:2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "29°C"
                font.pointSize: 28
            }
            Text {
                text: "Humidité: " + humid + "%"
                color: "grey"
            }
            Text {
                text: "Précipitations: " + rain + "%"
                color: "grey"
            }
            Text {
                text: "Vent: " + wind + " km/h"
                color: "grey"
            }
        }
    }


    Item {
        id: rectangle_image
        width: parent.width/2
        height: parent.height/2 - 10
        anchors.left: rectangle_info.right

        Image {
            source: "/meteo/" + icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            scale:0.18
        }
    }


    /* Section courbe */
    Rectangle {
        id: canevas
        width: parent.width
        height: parent.height/2-10
        anchors.top: rectangle_image.bottom
        Canvas {
            id: c
            anchors.fill:parent
            contextType: "2d"
            anchors.margins: 5

            Component {
                id: comp
                PathCurve { }
            }

            property var paths : [
                //comp.createObject(c, {"x": 75, "y": 75} )
            ]

            Path {
                id: myPath
                startX: -50; startY: 100
                pathElements: paths
            }

            onPaint: {
                context.strokeStyle = "#ffcc00";
                context.fillStyle = "#FFCC80"
                context.globalAlpha = 0.8;
                context.path = myPath;
                context.lineWidth = 3;
                context.fill();
                context.stroke();
            }

            Component.onCompleted: {
                /* element a gauche */
                paths.push(comp.createObject(c, {"x": -20, "y": Math.floor(Math.random()*30) + 50} ))

                /* Diffs values */
                var i
                for (i=0; i<8; i++)
                    paths.push(comp.createObject(c, {"x": i*50, "y": Math.floor(Math.random()*30) + 50} ))

                /* element a droite */
                paths.push(comp.createObject(c, {"x": 360, "y": Math.floor(Math.random()*30) + 50} ))
                paths.push(comp.createObject(c, {"x": 400, "y": 100} ))

                //paths[3] = comp.createObject(c, {"x": 150, "y": 80} )
                myPath.pathElements = paths
            }
        }

        Row {
            id: row_icons
            width: parent.width
            height: parent.height/3
            Repeater {
                id: repeater_icons
                model:5
                Item {
                    width: parent.width/5
                    height: parent.height
                    Image {
                        source: "/meteo/" + "02d"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        scale:0.05
                    }
                }
            }
        }

        Row {
            width: parent.width
            height: parent.height/3
            anchors.top: row_icons.bottom
            Repeater {
                id: repeater_temp
                model:5
                Item {
                    width: parent.width/5
                    height: parent.height
                    property int r_temp: 12
                    Text {
                        font.pointSize: 10
                        text: r_temp + "°C"
                        color: "black"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

    /* Section heures */
    Rectangle {
        width: parent.width
        height: parent.height/2-20
        anchors.top: canevas.bottom

        Row {
            width: parent.width
            height: parent.height
            Repeater {
                id: repeater_hours
                model:5
                Item {
                    width: parent.width/5
                    height: parent.height
                    property int hour: 12
                    // repeater_hours.itemAt(index).hour = newValue
                    Text {
                        text: (hour+index*3) % 24 + "h"
                        color: "grey"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

}
