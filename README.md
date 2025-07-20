# 🌦️ Weatherly - iOS Weather App

A clean, lightweight iOS weather app built using **Swift + UIKit + MVVM + Alamofire + SDWebImage**, with persistent search history and auto-refreshing weather updates.

---

## 🚀 Features

- 🔍 Search weather by **city name**
- 🌡️ View:
  - City name
  - Temperature (in Celsius)
  - Weather condition
  - Icon for current condition
- 🧠 **MVVM architecture**
- 💾 Stores recent searches via `UserDefaults`
- 📋 Shows previous cities in a dropdown table
- 🔁 **Auto-refreshes weather every 60 seconds**
- 🌐 SDWebImage for smooth icon loading
- ❌ Handles API errors and empty input cleanly

---

## 📱 Screenshots
<img width="1179" height="2556" alt="simulator_screenshot_300CFCF4-DCF1-49A0-A840-96766368DE70" src="https://github.com/user-attachments/assets/3ba23509-cda5-475a-88a8-af193bd5621b" />

## 📱 Video
https://github.com/user-attachments/assets/f5d3cc25-9b6e-44e2-b13b-6384d9a9ea00

## 🧱 Architecture Overview

### 🔄 Flow:
1. **User enters city** → taps "Get Weather"
2. ViewModel calls API via `WeatherService`
3. Response is parsed into `WeatherResponse`
4. ViewModel updates the ViewController via closure
5. Weather card and icon are updated
6. Search term is saved in `UserDefaults`
7. TableView shows recent cities
8. Timer triggers auto-refresh every 60 seconds

---

## 🧪 Tech Stack

| Layer         | Tool                   |
|---------------|------------------------|
| UI            | UIKit + Storyboard     |
| Architecture  | MVVM                   |
| Networking    | Alamofire              |
| Image Loader  | SDWebImage             |
| Persistence   | UserDefaults           |
