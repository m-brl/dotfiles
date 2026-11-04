import QtQuick

import "../constants"

Item {
    id: root

    property real gridStep: 10
    property real gridColumns: 10
    property color gridColor: Theme.base3

    required property var history
    property int maxPoints: 60

    readonly property var points: {
        const smoothing = 0.3
        const raw = history.slice(-maxPoints)
        const out = []
        let s = raw.length > 0 ? raw[0] : 0
        for (const v of raw) {
            s = smoothing * v + (1 - smoothing) * s
            out.push(s)
        }
        return out
    }

    property real floor: 0
    property real ceiling: Math.max(floor, ...history.slice(-maxPoints))

    onHistoryChanged: canvas.requestPaint()

    function tracePath(ctx, pts, step, y) {
        ctx.moveTo(0, y(pts[0]))
        for (let i = 1; i < pts.length - 1; i++) {
            const xc = (i + 0.5) * step
            const yc = (y(pts[i]) + y(pts[i + 1])) / 2
            ctx.quadraticCurveTo(i * step, y(pts[i]), xc, yc)
        }
        ctx.lineTo((pts.length - 1) * step, y(pts[pts.length - 1]))
    }

    function traceGrid(ctx) {
        ctx.strokeStyle = root.gridColor
        ctx.lineWidth = 1
        ctx.beginPath()

        // Lignes horizontales (valeurs)
        for (let v = root.gridStep; v < root.ceiling; v += root.gridStep) {
            const gy = Math.round(height - v / root.ceiling * height) + 0.5
            ctx.moveTo(0, gy)
            ctx.lineTo(width, gy)
        }

        // Lignes verticales (temps)
        const colStep = width / (root.maxPoints - 1) * root.gridColumns
        for (let gx = colStep; gx < width; gx += colStep) {
            const px = Math.round(gx) + 0.5
            ctx.moveTo(px, 0)
            ctx.lineTo(px, height)
        }
        ctx.stroke()

        if (true) {
            ctx.fillStyle = Theme.base3
            ctx.font = "9px sans-serif"
            ctx.textBaseline = "bottom"
            for (let v = root.gridStep; v < root.ceiling; v += root.gridStep)
            ctx.fillText(v + " W", 2, height - v / root.ceiling * height - 1)
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            const pts = root.points
            if (root.points.length < 2 || root.ceiling <= 0) return

            const step = width / (root.maxPoints - 1)
            const y = v => height - Math.min(v / root.ceiling, 1) * height

            ctx.beginPath()
            root.tracePath(ctx, pts, step, y)
            ctx.lineTo((pts.length - 1) * step, height)
            ctx.lineTo(0, height)
            ctx.closePath()
            ctx.fillStyle = Theme.green
            ctx.fill()

            // Contour
            ctx.beginPath()
            root.tracePath(ctx, pts, step, y)
            ctx.strokeStyle = "#00ff14"
            ctx.lineWidth = 1.5
            ctx.lineJoin = "round"
            ctx.stroke()

            root.traceGrid(ctx)
        }
    }
}
