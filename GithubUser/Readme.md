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
https://drive.google.com/file/d/1ngwWd-srBIVIfuEWsNzZjIWe--D54lOm/view?usp=sharing

# GithubUser Project

This project is a SwiftUI-based **GitHub User Explorer** application structured using the **MVVM** architecture.

# Project Structure

```plaintext
GithubUser
│
├── GithubUser
│   ├── Models
│   │   └── GithubUserModel.swift          # Defines the data model for GitHub user
│   │
│   ├── Preview Content
│   │   └── Preview Assets                 # Assets for SwiftUI Previews
│   │
│   ├── Services
│   │   └── ApiServices.swift              # Handles API calls and data fetching
│   │
│   ├── View
│   │   ├── DetailView.swift               # Detailed view for a GitHub user
│   │   └── MainView.swift                 # Main SwiftUI view (User Interface)
│   │
│   ├── ViewModel
│   │   └── GithubUserViewModel.swift      # Business logic and interaction with the Model
│   │
│   ├── Assets
│   │   └── [Visual assets here]           # App assets (images, colors, etc.)
│   │
│   ├── ContentView.swift                  # Main content view entry point
│   └── GithubUserApp.swift                # App entry point (@main structure)
│
├── GithubUserTests
│   └── GithubUserTests.swift              # Unit tests for Model and ViewModel
│
└── GithubUserUITests
    ├── GithubUserUITests.swift            # UI tests for user interface
    └── GithubUserUITestsLaunchTests.swift # Tests app launch and initial UI state
