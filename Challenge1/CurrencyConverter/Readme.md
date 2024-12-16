# Running Swift Code in Xcode

### 1. Open the Project
Double-click the `.xcodeproj` or `.xcworkspace` file to open the project in Xcode.

### 2. Select the Target
- In the top-left dropdown, choose the desired **scheme** (e.g., the app or framework to run).
- Pick the **destination**, such as a simulator (e.g., iPhone 15 Pro) or a connected device.

### 3. Run the Project
- Press `Command + R`, or
- Click the **Run** button (▶) at the top of the Xcode window.

### 4. View Results
- The app will launch in the selected simulator or on the connected device.
- Logs and errors will appear in the **Debug Console** at the bottom of Xcode.

### 5. Video link:
https://drive.google.com/file/d/1gkKTOxnyoZMAg1XRPNIG6wH45qBkCip0/view?usp=sharing

# CurrencyConverter Project

This project is a SwiftUI-based **Currency Converter** application structured using the **MVVM** architecture.

# Project Structure

```plaintext
CurrencyConverter
│
├── CurrencyConverter
│   ├── Model
│   │   └── CurrencyConverterModel.swift   # Handles data and logic for currency conversion
│   │
│   ├── Preview Content
│   │   └── Preview Assets                 # Assets for SwiftUI Previews
│   │
│   ├── Utility
│   │   └── ColorHex.swift                 # Helper for color utilities (e.g., Hex to Color)
│   │
│   ├── ViewModel
│   │   └── CurrencyConverterViewModel.swift  # Business logic and interaction with Model
│   │
│   ├── Assets
│   │   └── [Visual assets here]           # App assets (images, colors, etc.)
│   │
│   ├── ContentView.swift                  # Main SwiftUI view (User Interface)
│   └── CurrencyConverterApp.swift         # App entry point (@main structure)
│
├── CurrencyConverterTests
│   ├── CurrencyConverterTests.swift       # Unit tests for CurrencyConverterModel
│   └── CurrencyConverterViewModelTests.swift # Unit tests for ViewModel
│
└── CurrencyConverterUITests
    ├── CurrencyConverterUITests.swift     # UI tests for the app
    └── CurrencyConverterUITestsLaunchTests.swift # Tests app launch and initial UI state
