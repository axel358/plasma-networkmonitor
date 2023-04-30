import QtQuick 2.0
import QtQuick.Controls 2.5 as QQC2
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
    property alias cfg_refreshInterval: refreshInterval.value
    property alias cfg_displayStyle: displayStyle.currentIndex
    property alias cfg_minimumSpeed: minimumSpeed.value

    QQC2.SpinBox {
        id: refreshInterval
        from: 250
        to: 5000
        stepSize: 250
        Kirigami.FormData.label: i18n("Refresh interval: ")
    }

    QQC2.ComboBox {
        id: displayStyle
        Kirigami.FormData.label: i18n("Display style: ")
        model: [i18n("Combined"), i18n("Both"), i18n("Download only"), i18n("Upload only")]
    }

    QQC2.SpinBox {
        id: minimumSpeed
        from: 1024
        to: 1048576
        stepSize: 1024
        Kirigami.FormData.label: i18n("Minimum speed (bytes/s): ")
    }
}
