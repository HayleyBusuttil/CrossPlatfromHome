## Wise wallett
Wise Wallet is a simple and intuitive budgeting app designed to help you take control of your finances. It allows you to track income and expenses, monitor your monthly budget, and gain clear insights into where your money is going.

# Figma Design
E&C2 – Cross-Platform UI Design

The Wise Wallet interface was designed in Figma with a clean, modern approach to budgeting and financial tracking. 

View the full design here: https://www.figma.com/design/NXiasc4mmEvjmqxIDIIW8t/CrossPlatformHome?node-id=0-1&t=NMSDxDNRyZOyei8g-1 

# UI
The project is structured using a clear separation to improve readability and maintainability.
- Data models are defined separately to represent core application data like transactions.
- Screens are used to manage full application views and user navigation.
- Reusable widgets are extracted for repeated UI elements like transaction items and lists. 

# Local Persistent Storage
R&U4, A&A3– Native Platform Functionality

Local persistent storage was implemented using the Hive database package. 
To implement this feature, the project dependencies were updated in pubspec.yaml, and Hive adapters were generated using build_runner. 
The transaction data model was modified to support Hive annotations, allowing transaction objects to be stored locally. 
Hive was initialised in main.dart, and the home screen was updated to load transactions from storage on app startup and save new transactions when they are added by the user.

During testing on Chrome, saved data was not visable after restarting the app due to the browser assigning a different localhost port on each run. 
This issue was resolved by running the application with a fixed web port using "flutter run -d chrome --web-port 5000", this ensured consistent browser storage access between runs.

# Device-Specific Feature (camera)
R&U3 – Device-Specific Feature

The device camera was integrated using the image_picker package to allow users to capture receipt images when adding a transaction. The captured image is returned to the application and stored as part of the transaction data.

# Local Notifications
A&A4 – Notifications / Background Services 

Local notifications were implemented using the flutter_local_notifications package. The app triggers a high-priority notification when the user logs an expense above a defined threshold (€50), providing immediate feedback and encouraging better spending awareness.