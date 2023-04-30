import QtQuick 2.0
import org.kde.plasma.components 3.0 as PC3
import org.kde.plasma.plasmoid 2.0
import QtQuick.Layouts 1.0
import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.ksysguard.formatter 1.0

Item {

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    id: widget
    Plasmoid.compactRepresentation: Item {
        Layout.minimumWidth: speedLabel.implicitWidth
        Layout.minimumHeight: speedLabel.implicitHeight

        Timer {
            id: updateTimer
            interval: plasmoid.configuration.refreshInterval
            repeat: true
            running: true
            onTriggered: {
                updateData()
            }
        }

        PC3.Label {
            id: speedLabel
            anchors.fill: parent
            text: "\u21f5"
            horizontalAlignment: Text.AlignHCenter
        }

        Sensors.Sensor {
            id: "downSensor"
            sensorId: "network/all/download"
            updateRateLimit: plasmoid.configuration.refreshInterval
        }

        Sensors.Sensor {
            id: "upSensor"
            sensorId: "network/all/upload"
            updateRateLimit: plasmoid.configuration.refreshInterval
        }

        function updateData() {
            const totalSpeed = upSensor.value + downSensor.value

            if (totalSpeed > plasmoid.configuration.minimumSpeed) {
                switch (plasmoid.configuration.displayStyle) {
                    case 0:
                        speedLabel.text = "\u21f5 " + Formatter.formatValue(totalSpeed, Units.UnitByteRate)
                        break
                    case 1:
                        speedLabel.text = "\u2191 " + upSensor.formattedValue + "  \u2193 " + downSensor.formattedValue
                        break
                    case 2:
                        speedLabel.text = "\u2193 " + downSensor.formattedValue
                        break
                    case 3:
                        speedLabel.text = "\u2191 " + upSensor.formattedValue
                }
            }
            else
                speedLabel.text = "\u21f5"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: plasmoid.expanded = !plasmoid.expanded
        }
    }


    Plasmoid.fullRepresentation: Item {

        RowLayout {

            PC3.Label {
                text: "Under construction ;)"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
