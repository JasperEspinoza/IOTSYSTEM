# ESP32 Classroom IoT Monitoring & Alert System - Web Interface

A real-time, responsive IoT web dashboard designed specifically for your ESP32 Classroom Environmental & Security Monitoring system.

## 🚀 Quick Start (Local)

1. **One-Click Launch (Windows)**:
   - Double-click **`run.bat`** (or `start.bat`) inside this folder.
   - It will automatically start the server and open your default browser to **`http://localhost:3000`**.
2. **Manual Command Line**:
   - Run `npm start` (or `node server.js`).
   - Open your browser to **[http://localhost:3000](http://localhost:3000)**.

---

## 🌐 Production Hosting & Cloud Deployment

Because this dashboard communicates with your Firebase Realtime Database over secure WebSockets & HTTPS, it can be hosted anywhere for free without server maintenance:

### Option A: Firebase Hosting (Recommended ⭐)
Since your project already uses Firebase (`classroom-monitoring-sys-3a0b0`), you get free global CDN hosting with automatic SSL:
1. **One-Click Deploy (Windows)**:
   - Double-click **`deploy-firebase.bat`**.
2. **Or via Command Line**:
   ```bash
   firebase login
   npm run deploy:firebase
   ```
3. Your live production URL will be:
   - **`https://classroom-monitoring-sys-3a0b0.web.app`**
   - **`https://classroom-monitoring-sys-3a0b0.firebaseapp.com`**

### Option B: Vercel
Pre-configured with `vercel.json`:
```bash
npm install -g vercel
vercel --prod
```

### Option C: Netlify
Pre-configured with `netlify.toml`:
- Drag and drop this project folder into [Netlify Drop](https://app.netlify.com/drop), or connect your GitHub repository.

### Option D: Node.js Cloud Hosts (Render / Railway / Heroku / Fly.io)
Pre-configured with `Procfile` and `package.json`:
- **Build command**: (none needed)
- **Start command**: `npm start`
- **Health check path**: `/health`

### Option E: Docker
```bash
docker build -t esp32-iot-dashboard .
docker run -p 3000:3000 esp32-iot-dashboard
```

---

## 🖥️ Dashboard Features

| Feature | Description | Mapped ESP32 Parameter |
| :--- | :--- | :--- |
| **Real-Time Temperature Card** | Live °C and °F readings with interactive threshold quick-adjust controls | `sensor/temperature`, `control/temp_threshold` |
| **Relative Humidity Card** | Live % humidity reading with comfort classification | `sensor/humidity` |
| **Light & Dark Mode** | One-click adaptive theme toggle with Chart.js dynamic color adaptation and persistence | Client-side `localStorage` (`theme`) |
| **Dynamic Threshold Control** | Remote over-the-air cutoff editing with instant ESP32 & Cloud sync | `control/temp_threshold` |
| **Device Connection Banner** | Floating glassmorphism toast & audio chime when ESP32 connects/reconnects | `sensor/device_status`, `sensor/last_boot_time` |
| **PIR Motion Detection** | Visual badge, motion cooldown indicator & timestamp | `sensor/motion_detected`, `sensor/last_motion_timestamp` |
| **ESP32 Actuator Mirrors** | Live virtual status of physical Green LED, Red LED, and Buzzer | `GREEN_LED` (Pin 22), `RED_LED` (Pin 23), `BUZZER_PIN` (Pin 18) |
| **Critical Alarm Banner** | Flashes when temp $\ge$ dynamic threshold with dynamic temperature readout | `sensor/high_temp_alert` |
| **Web Audio Buzzer Sound** | Web Audio synthesizer simulates the physical buzzer beep in browser | Aligned with high-temperature trigger |
| **Streaming Chart** | Real-time dual-axis graph (Temp & Hum) + dynamic threshold cutoff line | `dhtReadInterval` (2000 ms) |
| **Event & Alert Audit Log** | Chronological log of motion, threshold alerts, and normal restorations | Exportable to CSV |
| **Demo / Simulation Mode** | One-click button to simulate sensor telemetry before hardware is on | Top navigation bar |

---

## 🔌 Hardware & Pin Mapping

| ESP32 Pin | Component | Function | Normal State ($< 35^\circ\text{C}$) | Alert State ($\ge 35^\circ\text{C}$) |
| :--- | :--- | :--- | :--- | :--- |
| **GPIO 14** | DHT11 | Temp & Humidity Data | Reading every 2000ms | Reading every 2000ms |
| **GPIO 27** | PIR Sensor | Motion Detection | `LOW` | `HIGH` (Cooldown 5s) |
| **GPIO 22** | Green LED | System Normal Indicator | `HIGH` (On) | `LOW` (Off) |
| **GPIO 23** | Red LED | System Warning Indicator | `LOW` (Off) | `HIGH` (On) |
| **GPIO 18** | Active Buzzer | Audible Alarm Indicator | `LOW` (Silent) | `HIGH` (Sounding) |
| **GPIO 2** | Built-in Blue LED | Wi-Fi & Motion Indicator | Blinks while connecting; **Turns ON whenever motion is detected** | OFF (when no motion) |

---

## 🧪 Hardware Isolation Test

If you need to verify your DHT sensor wiring independently, upload **`test_dht.ino`**. It prints raw temperature and humidity directly to the Serial Monitor every 2 seconds without Wi-Fi or Firebase dependencies.

---

## 🔒 Firebase Realtime Database Rules

In your Firebase Console (`https://console.firebase.google.com/`), ensure your **Realtime Database Rules** permit read and write access for anonymous authenticated users (or public during testing):

```json
{
  "rules": {
    "sensor": {
      ".read": true,
      ".write": "auth != null"
    },
    "control": {
      ".read": true,
      ".write": true
    }
  }
}
```

> **Note**: Also verify that **Anonymous Authentication** is enabled in Firebase Console $\rightarrow$ **Authentication** $\rightarrow$ **Sign-in method** $\rightarrow$ **Anonymous** $\rightarrow$ **Enabled**.

