# NasaPodProject

## Overview
NasaPodProject is an iOS application that fetches data from NASA's Astronomy Picture of the Day (APOD) API. The app features:
1. Displaying today's Astronomy Picture of the Day along with metadata.
2. Viewing the 30 most recent APOD entries, with the ability to navigate to detailed views.


---
# Assumptions About the API Response

The implementation assumes that the API returns a JSON array where each element is an object representing a single Astronomy Picture of the Day (APOD) with the following structure:

### 1. **Mandatory Fields**:
- `date` (string): The date of the APOD in `YYYY-MM-DD` format.
- `explanation` (string): A detailed description of the image or video.
- `media_type` (string): Type of media, e.g., "image" or "video."
- `title` (string): Title of the APOD.
- `url` (string): URL to the image or video of the APOD.

### 2. **Optional Fields**:
- `hdurl` (string): URL to the high-definition version of the APOD.
- `copyright` (string): Attribution or copyright information (if available).
- `service_version` (string): Version of the API service.

### 3. **Data Constraints**:
- Each object is expected to have a unique `date`.
- Additional fields in the response will be ignored unless explicitly specified in the requirements.
---

## File Structure

### **`ApiNetworking.swift`**
Handles all networking operations with the NASA APOD API.

- **Key Functions**:
  - `fetchPictureOfTheDay(completion: @escaping (Result<PictureOfTheDay, Error>) -> Void)`: Fetches today's Astronomy Picture of the Day and metadata.
  - `fetchRecentPictures(completion: @escaping ([PictureOfTheDay]) -> Void)`: Retrieves the 30 most recent APOD entries, using start and end dates.

- **API Base URL**: `https://api.nasa.gov/planetary/apod`
- **Dependencies**: Uses `URLSession` for HTTP requests and `JSONDecoder` for parsing responses.
---
## Project Structure
```
NasaPodProject
├── Models
│   └── PictureOfTheDay.swift
├── ViewModels
│   ├── PictureOfTheDayViewModel.swift
│   └── RecentPicturesViewModel.swift
├── Views
│   ├── TodayPictureView.swift
│   ├── RecentPicturesView.swift
│   └── FeedPicturesOfTheDay.swift
├── Networking
│   └── ApiNetworking.swift
│   └── Utility.swift
├── Tests
│   ├── ApiNetworkingTests.swift
│   ├── PictureOfTheDayViewModelTests.swift
│   └── MockApiNetworking.swift
├── ContentView.swift
└── NasaPodProjectApp.swift
```
---

### **`Utility.swift`**
Contains helper functions for date management.

- **Functions**:
  - `getTodaysDate() -> String`: Returns today's date in `yyyy-MM-dd` format.
  - `getStartDate() -> String`: Calculates and returns the date 30 days prior in `yyyy-MM-dd` format.

These utilities ensure the app correctly constructs API requests for the recent pictures feature.

---

### **`Models/`**
Defines data structures for decoding API responses.

- **`PictureOfTheDay.swift`**:
  - A Swift struct conforming to `Codable` to represent the APOD response.
  - Fields include:
    - `title`: The title of the picture.
    - `date`: The date the picture was published.
    - `url`: The URL of the image.
    - `explanation`: A brief description of the picture.
    - Additional metadata fields such as `hdurl` and `media_type`.

---

### **`Views/`**
Manages the app's user interface components.

- **`TodayViewController.swift`**:
  - Displays today's APOD with its title, description, and image.
  - Fetches data using `ApiNetworking.shared.fetchPictureOfTheDay`.

- **`RecentPicturesViewController.swift`**:
  - Shows a scrollable list of the 30 most recent APOD entries.
  - Data is retrieved via `ApiNetworking.shared.fetchRecentPictures`.

- **`DetailViewController.swift`**:
  - Displays detailed information for a selected APOD, including a larger image and full metadata.

---

### **`ViewModels/`**
Handles logic to bridge the model and view layers.

- **`TodayViewModel.swift`**:
  - Processes the API response for display in the `TodayViewController`.

- **`RecentPicturesViewModel.swift`**:
  - Maps the list of recent APOD entries for use in `RecentPicturesViewController`.

---

## Testing
The project includes unit tests to ensure reliability:

1. **`ApiNetworkingTests`**:
   - Tests for API calls and date calculations.
2. **`PictureOfTheDayViewModelTests`**:
   - Tests for `PictureOfTheDayViewModel` methods.
3. **`MockApiNetworking`**:
   - Provides mock networking calls for testing purposes.

### Running Tests
- Use Xcode's Test Navigator or run the tests via `Command + U`.

---

## API Integration

The app integrates with NASA's APOD API for its features.

- **Endpoints**:
  1. **Fetch Today's Picture**:
     `https://api.nasa.gov/planetary/apod?api_key=<API_KEY>`
  2. **Fetch Recent Pictures**:
     `https://api.nasa.gov/planetary/apod?api_key=<API_KEY>&start_date=<YYYY-MM-DD>&end_date=<YYYY-MM-DD>`

- **Date Logic**: The `start_date` and `end_date` parameters are dynamically calculated using `Utility.swift`.


### Example API Response
```json
{
  "copyright": "John Doe",
  "date": "2025-01-15",
  "title": "A Beautiful Nebula",
  "explanation": "This is a detailed explanation of the nebula.",
  "url": "https://example.com/image.jpg",
  "media_type": "image"
}
```

---

## Installation & Setup

1. Clone the repository.
2. Open the project in Xcode.
3. Replace the placeholder `apiKey` in `ApiNetworking.swift` with your NASA API key.
4. Build and run the project on a simulator or a physical device.

---

## Future Enhancements

- Implement persistent caching to reduce API requests and improve offline functionality.
- Add animations for better user experience when transitioning between screens.
- Support custom date ranges for the Recent Pictures feature.
- Introduce accessibility improvements for visually impaired users.

---


