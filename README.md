# EV Assist

EV Assist is a specialized mobile application designed to help Electric Vehicle (EV) owners plan their trips with confidence. By analyzing vehicle consumption and trip parameters, it calculates exactly how much charge is required to reach a destination safely, ensuring you never run out of range.

## Features

- **Intelligent Charge Calculation**: Computes the precise energy needed based on your vehicle's specific consumption profile.
- **Safety First**: Incorporates a safety buffer calculation to account for unforeseen circumstances.
- **Flexible Capacity Handling**: Supports both Net (usable) and Gross (total) battery capacity settings, automatically adjusting for non-usable buffers.
- **Internationalization**: Fully localized in 9 languages: Danish, German, English, Spanish, Finnish, French, Norwegian, Polish, and Swedish.
- **Adaptive UI**: Features a modern interface with full support for Light and Dark themes to match your system preferences.

## Application Screens

The application is structured around a streamlined user experience:

1.  **Home Screen**: The primary interface where all trip planning takes place. It contains input fields for vehicle data and trip details, and displays the calculation results.
2.  **Settings Screen**: Accessible via the gear icon, this screen allows customization of the app's visual theme (System default, Light mode, or Dark mode).
3.  **Splash Screen**: A theme-aware welcome screen that greets users upon launch.

## How It Works

### User Inputs through the Home Screen

To perform a calculation, the user enters the following data:

*   **Average Consumption**: Your EV's energy usage (e.g., in kWh).
*   **Distance Reference**: The distance corresponding to the consumption value (defaults to 100 for kWh/100km).
*   **Destination Distance**: The actual distance to your planned destination.
*   **Total Battery Capacity**: The size of your battery in kWh.
    *   *Capacity Type*: Choose between **Net** (usable energy) or **Gross** (total capacity). Selecting 'Gross' automatically deducts a 4.0 kWh technical buffer.
*   **Current Battery Level**: Your current charge percentage (0-100%).
*   **Desired Arrival Level**: The percentage of battery you want to have remaining when you arrive (e.g., 10% or 20%).

### Results & Output

Once the **Calculate** button is pressed, the app processes the data and provides immediate feedback:

*   **Charge Required**: Displays the exact amount of energy (in kWh) you need to charge to reach your destination with the desired remaining battery level.
*   **Smart Warnings**:
    *   If the destination is unreachable even with a full charge.
    *   If the required charge exceeds the physical limits of the battery.

## Technical Details

Built with **Flutter**, EV Assist leverages the Provider pattern for efficient state management and utilizes Google Mobile Ads for integration. The app employs a robust calculation logic that factors in current energy state, trip consumption, and a standardized 20% consumption safety margin.
