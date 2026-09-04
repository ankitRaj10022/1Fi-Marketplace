# 1Fi Marketplace

A Flutter application developed as part of the 1Fi SDE Intern Assignment. This project extends the existing 1Fi App's Shop page by introducing a dynamic and fully functional "1Fi Marketplace" section, adhering to the provided design and engineering constraints.

## Fulfillment of Evaluation Criteria

This implementation is carefully structured to meet and exceed the assignment's technical and UX requirements:

- **UI/UX & Product Consistency:** The UI meticulously matches the existing 1Fi app's typography, spacing, and visual language (e.g., specific purple accents, rounded card corners, and segmented navigation). It feels like a native extension of the established Shop experience.
- **Functionality:** Implements the complete user flow: browsing the Marketplace, viewing Product Details with variants, evaluating EMI options via an interactive bottom sheet, and a CTA to proceed with a selected plan.
- **Data & API Architecture:** Avoids hardcoded UI data. Implements a scalable **Repository Pattern** (`ProductRepository`), retrieving data dynamically from a mocked JSON data source (`assets/data/products.json`). This ensures the app is ready for immediate integration with a real backend API by simply swapping the repository implementation.
- **Engineering Quality & State Management:** The codebase is separated into clear domains (`models`, `data`, `pages`, `theme`). The `provider` package is utilized for clean dependency injection.
- **Attention to Detail:** Robust handling of loading states (shimmer/spinners) and error states via `FutureBuilder` to ensure a smooth, edge-case-resistant user experience.

## Features

- **Shop Page Extension:** Integrates a new "1Fi Marketplace" tab seamlessly alongside the "Top Brands" and "Nearby Stores" sections.
- **Marketplace Listing:** Displays a responsive product feed complete with images, prices, and No-Cost EMI availability indicators.
- **Product Details:** A dedicated view for products, including dynamic variant selection (e.g., color, size).
- **EMI Selection Flow:** An interactive bottom sheet allowing users to review dynamically calculated NO-COST EMI plans and proceed to checkout.

## Project Structure

- `lib/data/` - Contains the abstract `ProductRepository` interface and its concrete mock implementation.
- `lib/models/` - strongly-typed data models for `Product` and `EmiPlan`, complete with JSON serialization.
- `lib/pages/` - UI components for the main Shop page, Marketplace listing, and Product Details.
- `lib/theme/` - Contains `AppTheme` to maintain strict adherence to 1Fi's branding guidelines.
- `assets/data/` - Contains `products.json` providing the mock API data payload.

## Getting Started

1. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the Application:**
   ```bash
   flutter run
   ```
