import qs.services
import qs

OsdSlider {
    active: Monitor.brightnessChanged
    text: Monitor.brightnessPercent() < 0.5 ? "󰃞" : "󰃠"
    value: Monitor.brightnessPercent()
    borderColor: Theme.osdBrightnessBorder
}
