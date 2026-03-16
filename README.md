FaceID + API Fetching App with BLoC (Clean Architecture)
This is a Flutter mobile application demonstrating a complete implementation of FaceID authentication, API data fetching, and state management using BLoC following clean architecture principles.

Features
FaceID / Biometric Authentication
Users authenticate using their device’s biometric sensors (FaceID / Fingerprint).
Only authenticated users can access the posts screen.
API Data Fetching
Fetch posts from a public API (JSONPlaceholder
).
Supports pagination, fetching posts in batches (e.g., 5 posts at a time).
Refresh functionality to load additional posts.
BLoC + Clean Architecture
Presentation Layer: Screens and widgets.
Domain Layer: Business logic (events & states).
Data Layer: Repository and API services.
State Management: flutter_bloc to handle fetching, refreshing, deleting, and archiving posts.

Post Management
Swipe actions: Archive or Delete posts.
Archived posts are stored separately and can be viewed on a dedicated Archived Screen.
Supports pull-to-refresh and incremental post loading.
Professional UI / UX
Clean, responsive UI.
Animated swipe actions for posts.
WhatsApp-style archived posts section.
