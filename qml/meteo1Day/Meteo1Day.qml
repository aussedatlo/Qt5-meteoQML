import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    id: meteo1Day
    visible: true
    width: 320
    height: 240
    property string temp: ""
    property string icon: ""
    property string humid: ""
    property string wind: ""
    property string precip: ""
    property string hour: ""


    Component {
        id: comp
        PathCurve { }
    }

    property var paths : [
        comp.createObject(c, {"x": -100, "y": 110} ),
        comp.createObject(c, {"x": 0, "y": 110} ),
        comp.createObject(c, {"x": 50, "y": 110} ),
        comp.createObject(c, {"x": 100, "y": 110} ),
        comp.createObject(c, {"x": 150, "y": 110} ),
        comp.createObject(c, {"x": 200, "y": 110} ),
        comp.createObject(c, {"x": 470, "y": 110} ),
        comp.createObject(c, {"x": 470, "y": 110} )
    ]

    Connections
    {
        target:meteoManager
        ignoreUnknownSignals: true
        onUpdateMeteo1Day: {
            temp = p_temp
            icon = p_icon
            precip = p_precip
            wind = p_wind
            humid = p_humid
            hour = p_hour
       }
       onUpdateMeteo1Day_hours: {
           repeater_icons.itemAt(p_index-1).r_icon = p_icon;
           repeater_temp.itemAt(p_index-1).r_temp = p_temp;
           paths[p_index] = comp.createObject(c, {"x": 70*(p_index)-35, "y": 90-p_temp} );
           /* first element */
           if (p_index == 1) {
               paths[0] = comp.createObject(c, {"x": -35, "y": 90-p_temp} );
           }
           /* Last element*/
           if (p_index == 5) {
               paths[6] = comp.createObject(c, {"x": 70*6-35, "y": 90-p_temp} );
               myPath.pathElements = paths;
               c.requestPaint();
           }
       }
    }

    MouseArea {
            anchors.fill: parent
            onClicked: {
                meteoManager.updateTarget(1);
                main.changeView("../meteo4Days/Meteo4Days.qml");
                meteoManager.updateData();
            }
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
                text: temp + "°C"
                font.pointSize: 28
            }
            Text {
                text: "Vent: " + wind + " km/h"
                color: "grey"
            }
            Text {
                text: "Humidité: " + humid + "%"
                color: "grey"
            }
            Text {
                text: "Précipitations: " + precip
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

            Path {
                id: myPath
                startX: -50; startY: 100
                pathElements: paths
            }

            onPaint: {
                context.clearRect(0, 0, c.width, c.height);
                context.strokeStyle = "#ffcc00";
                context.fillStyle = "#FFCC80"
                context.globalAlpha = 0.8;
                context.path = myPath;
                context.lineWidth = 3;
                context.fill();
                context.stroke();
            }

            Component.onCompleted: {
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
                    property string r_icon: "02d"
                    Image {
                        source: "/meteo/" + r_icon
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
                    property int hour: meteo1Day.hour
                    // repeater_hours.itemAt(index).hour = newValue
                    Text {
                        text: (hour+(index+1)*3) % 24 + "h"
                        color: "grey"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
