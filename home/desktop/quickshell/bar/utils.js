.pragma library

function getMinute(time) {
    return String(Math.floor(time / 60)).padStart(2, "0")
}

function getSecond(time) {
    return String(Math.floor(time % 60)).padStart(2, "0")
}

function sliceText(text, maxLength) {
    if (text.length <= maxLength) {
        return text;
    }

    return text.slice(0, maxLength) + '...';
}

function formatDuration(seconds) {
    if (!seconds || seconds <= 0) return ""

    var h = Math.floor(seconds / 3600)
    var m = Math.floor((seconds % 3600) / 60)

    if (h > 0) return h + "h " + String(m).padStart(2, "0") + "min"
    return m + "min"
}
