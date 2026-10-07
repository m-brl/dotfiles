import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.UPower

import "../services"
import "../components"

IconButton {
    id: root

    required property BatteryService batteryService

    property string batteryIcon: {
        if (root.batteryService.battery.state === UPowerDeviceState.Charging) return "\udb80\udc84"
 
        if (root.batteryService.battery.percentage >= 1.0) return "\udb80\udc79"
        if (root.batteryService.battery.percentage >= 0.9) return "\udb80\udc82"
        if (root.batteryService.battery.percentage >= 0.8) return "\udb80\udc81"
        if (root.batteryService.battery.percentage >= 0.7) return "\udb80\udc80"
        if (root.batteryService.battery.percentage >= 0.6) return "\udb80\udc7f"
        if (root.batteryService.battery.percentage >= 0.5) return "\udb80\udc7e"
        if (root.batteryService.battery.percentage >= 0.4) return "\udb80\udc7d"
        if (root.batteryService.battery.percentage >= 0.3) return "\udb80\udc7c"
        if (root.batteryService.battery.percentage >= 0.2) return "\udb80\udc7b"
        if (root.batteryService.battery.percentage >= 0.1) return "\udb80\udc7a"
        if (root.batteryService.battery.percentage >= 0) return "\udb80\udc7a"
    }

    value: `${root.batteryIcon} ${root.batteryService.battery.percentage * 100}%`
}
