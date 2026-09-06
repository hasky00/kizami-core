# LTC frame layout (SMPTE 12M)

80 bits per video frame, sent LSB-first as biphase-mark code.

| bits  | meaning                | bits  | meaning              |
|-------|------------------------|-------|----------------------|
| 0–3   | frame units (0–9)      | 32–35 | minute units         |
| 4–7   | user bits 1            | 36–39 | user bits 5          |
| 8–9   | frame tens (0–2)       | 40–42 | minute tens          |
| 10    | drop-frame flag        | 43    | binary group flag 0  |
| 11    | colour-frame flag      | 44–47 | user bits 6          |
| 12–15 | user bits 2            | 48–51 | hour units           |
| 16–19 | second units           | 52–55 | user bits 7          |
| 20–23 | user bits 3            | 56–57 | hour tens            |
| 24–26 | second tens            | 58    | binary group flag 1  |
| 27    | biphase polarity bit   | 59    | binary group flag 2  |
| 28–31 | user bits 4            | 60–63 | user bits 8          |
|       |                        | 64–79 | sync word 0011111111111101 |

Time fields are BCD, so `timecode.v` (binary counters) needs a
binary→BCD split before packing. Bit rate = 80 × fps (2000 bit/s at 25 fps).
