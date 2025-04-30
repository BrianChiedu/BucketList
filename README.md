# BucketList

BucketList is an iOS application that allows users to mark and track locations they want to visit on an interactive map. Users can add details, photos, and check off places they've visited.

## Features

- **Interactive Map**: Tap anywhere to add new locations to your bucket list
- **Location Details**: Add names, descriptions, and mark places as visited
- **Nearby Attractions**: Automatically fetches Wikipedia points of interest near each saved location
- **Biometric Security**: Protects your places with Face ID/Touch ID
- **Photo Integration**: Add images to your saved locations from your photo library
- **Map Style Options**: Toggle between standard and hybrid map views
- **Location Sharing**: Share location coordinates via URL

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone this repository
```bash
git clone https://github.com/yourusername/BucketList.git
```

2. Open the project in Xcode
```bash
cd BucketList
open BucketList.xcodeproj
```

3. Build and run the application on your device or simulator

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models**: `Location.swift`, `Result.swift`
- **Views**: `ContentView.swift`, `EditView.swift`
- **ViewModels**: `ContentView-ViewModel.swift`, `EditView-ViewModel.swift`

### Data Persistence

Location data is saved to the documents directory as JSON:
```swift
URL.documentsDirectory.appending(path: "SavedPlaces")
```

### External APIs

The app uses the Wikipedia API to fetch nearby points of interest based on location coordinates.

## Usage

1. Launch the app and authenticate if required
2. Tap on the map to add a new location
3. Tap a location pin to view or edit its details
4. Add photos, descriptions, and mark locations as visited
5. View nearby points of interest pulled from Wikipedia
6. Share locations with others



## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [MapKit](https://developer.apple.com/documentation/mapkit/)
- [Wikipedia API](https://www.mediawiki.org/wiki/API:Main_page)
