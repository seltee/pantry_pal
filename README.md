# PantryPal – Smart Pantry Tracker

**A clean and intuitive Flutter application designed to help users track pantry items and reduce food waste.**

PantryPal provides a simple yet powerful way to manage your pantry inventory with clear expiration tracking and a modern Material 3 interface.

## Live Demo

**Web Demo**: [PantryPal Live](https://seltee.github.io/pantry_pal/)

## Features

- Add, edit, and delete pantry items with name, category, quantity and expiration date
- Smart expiration tracking with color-coded indicators:
  - **Red** – Expired items
  - **Orange** – Expiring soon
  - **Green** – Fresh items
- Dashboard with quick statistics (Total items, Expiring soon, Expired)
- Real-time search and sortable list (by expiration date)
- Full dark and light theme support
- Fully responsive design for both mobile and web
- Persistent local data storage

## Tech Stack

- **Flutter**
- **Material 3**
- **SharedPreferences**

## How to Run

```bash
# Clone the repository
git clone https://github.com/seltee/pantry_pal.git

# Navigate to the project directory
cd pantry_pal

# Install dependencies
flutter pub get

# Run the app on web
flutter run -d chrome

```

## Key Highlights

- Clean architecture with clear separation of concerns
- Professional Material 3 UI/UX with smooth interactions and animations
- Efficient state management using Provider
- Robust JSON serialization and local persistence with SharedPreferences
- Support for both **Add** and **Edit** forms with proper validation
- Responsive design optimized for both web and mobile
- Smart expiration tracking with color-coded visual indicators
- Intuitive sorting and real-time search functionality

---

**Built with Flutter & ❤️**
