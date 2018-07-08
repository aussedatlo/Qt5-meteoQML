import QtQuick 2.7
import QtQuick.Controls 1.2
import "meteo1Day"
import "meteo4Days"
import "test"

ApplicationWindow {
    id:main
    visible: true
    width: 320
    height: 240

  Meteo4Days{
      id: meteo4days
  }

  Loader { id: pageLoader }

  function changeView(value) {
      console.log("index "+value)
      pageLoader.source = value
  }

}
