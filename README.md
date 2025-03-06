# homezs

A Flutter mobile application for browsing real estate listings with Firebase integration.

## Features

- Browse property listings with detailed information
- View property images, locations, prices, and amenities
- Search and filter properties
- Smooth navigation and animations
- Firebase backend integration
- Image hosting with ImgBB CDN

## Setup

1. Clone the repository
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Configure Firebase:
   - Create a new Firebase project
   - Add your Firebase configuration files
   - Enable Firestore Database
   - Set up Firebase Storage for images

4. Configure ImgBB:
   - Sign up at [ImgBB](https://imgbb.com/)
   - Get your API key from dashboard
   - Add to your environment variables or config file:
     ```
     IMGBB_API_KEY=your_api_key_here
     ```

5. Run the app:
   ```bash
   flutter run
   ```

Collections:
- properties
  - title: String
  - imageUrl: String (ImgBB URL)
  - location: String
  - price: Number
  - beds: Number
  - bathrooms: Number


