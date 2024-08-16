# E-Commerce App

## Overview

This E-Commerce app allows users to upload products with high-definition images, create ads, view ads from other users, and place orders based on their current location. It provides a dynamic platform for buying and selling items with a user-friendly interface and efficient functionality.

## Features

- **Product Upload:** Users can upload products with up to 5 HD quality images.
- **Ad Creation:** Users can create ads for their products.
- **Ad Viewing:** Users can view ads from other users.
- **Order Placement:** Users can place orders based on their current location.
- **User Location:** Integration with location services to view and order from nearby products.

## Packages Used

### Cupertino Icons
Provides a set of icons consistent with the iOS design language for use in the app's UI.

### Firebase Core
Initializes Firebase in the app, allowing other Firebase services to be used.

### Firebase Auth
Handles user authentication, including sign-in, sign-up, and password management.

### Cloud Firestore
Provides a NoSQL database to store and retrieve data related to products, ads, and user information.

### Timeago
Formats timestamps into readable relative time (e.g., "3 minutes ago") for user-friendly date display.

### Intl
Provides internationalization and localization support, allowing for date, time, and number formatting according to locale.

### Image Picker
Allows users to pick images from their device's gallery or camera, essential for product image uploads.

### Image Cropper
Provides functionality for cropping images before uploading, ensuring better image quality and presentation.

### Fluttertoast
Displays short messages (toasts) to provide feedback to the user, such as confirmation of actions.

### Firebase Storage
Handles the storage of user-uploaded images and files in Firebase Cloud Storage.

### Flutter Image Slider
Enables image sliders or carousels in the app, useful for displaying multiple product images.

### Flutter SVG
Allows the use of SVG (Scalable Vector Graphics) images, which are useful for icons and other vector-based graphics.

### Geolocator
Provides location services to get the user's current location for order placement based on proximity.

### Geocoding
Converts coordinates into human-readable addresses and vice versa, aiding in location-based functionality.

### URL Launcher
Opens URLs in the default web browser, useful for handling links within the app.

### Map Launcher
Launches maps apps with specified coordinates, useful for showing product locations on a map.

### UUID
Generates unique identifiers for product listings and orders, ensuring each entry is uniquely identifiable.

### Permission Handler
Manages permissions for accessing device features such as the camera and location services.

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/your-repository.git
    ```

2. Navigate to the project directory:

    ```bash
    cd your-repository
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Configure Firebase for both Android and iOS as per the [Firebase documentation](https://firebase.google.com/docs/flutter/setup).

5. Run the app:

    ```bash
    flutter run
    ```

## Usage

- **Upload Product:** Go to the upload section and add your product images and details.
- **Create Ad:** Navigate to the ad creation page to create and manage your ads.
- **View Ads:** Browse through ads created by other users.
- **Place Order:** Use the location-based feature to place orders for products near you.

## Contributing

Feel free to contribute by submitting issues or pull requests. For detailed guidelines, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

##Screens
