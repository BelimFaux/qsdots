import qs.services
import qs

OsdSlider {
    active: Audio.sinkChanged
    text: Audio.sinkMuted ? "󰝟" : Audio.volume < 0.3 ? "󰕿" : Audio.volume < 0.7 ? "󰖀" : "󰕾"
    value: Audio.volume < 1.0 ? Audio.volume : 1.0
    borderColor: Config.osdVolumeBorder
}
