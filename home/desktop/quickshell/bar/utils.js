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
