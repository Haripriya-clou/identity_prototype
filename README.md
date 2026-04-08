# Identity Prototype 🪪

A modern Flutter application for secure digital identity verification using QR codes and Firebase.

## 📱 Features

### User Features
- **User Verification**: Search and retrieve user credentials
- **QR Code Display**: Generate and display verification QR codes
- **Credential Management**: View complete user information
- **Quick Scanning**: Scan QR codes for instant verification

### Admin Features
- **Admin Dashboard**: Monitor and manage all registered credentials
- **Issuer Panel**: Add new users and generate credentials
- **Credential Issuance**: Create user credentials with ID validation
- **Data Synchronization**: Real-time sync with Firebase Firestore
- **Multi-Format Support**: Aadhar, PAN, and Driver's License support

### Security
- **End-to-End Encryption**: Secure credential transmission
- **QR-Based Verification**: Unique QR codes for each credential
- **Firebase Integration**: Cloud-based secure storage
- **User Authentication**: Admin login with Firebase Auth

---

## 🎨 Modern Design System

This app features a beautiful, modern UI with:

- **Material Design 3** - Latest design standards
- **Custom Theme** - Indigo, Emerald, and Amber color palette
- **Reusable Components** - 7+ custom UI components
- **Modern Typography** - Poppins & Inter fonts
- **Beautiful Gradients** - Smooth color transitions
- **Responsive Design** - Works on all devices
- **Accessibility** - WCAG AA compliant

### UI Components
- `ModernCard` - Gradient-based cards with icons
- `BeautifulButton` - Styled buttons with loading states
- `BeautifulTextField` - Enhanced input fields
- `SectionHeader` - Beautiful section titles
- `StatusBadge` - Status indicators
- `InfoCard` - Information display cards
- `GlassCard` - Glassmorphism containers

---

## 📱 Screens

### Home Screen
Beautiful landing page with three main action cards:
- User Verification
- Admin Panel
- Scan QR Code

### User Verification
- Select ID type (Aadhar, PAN, DL)
- Enter ID number
- Get verification QR code

### QR Display Screen
- Large, scannable QR code
- User information display
- Verification status

### Admin Login
- Email and password authentication
- Security guidelines
- Admin features overview

### Issuer Panel
- Add new users
- Form validation
- User list management
- Registered user count

### Scanner Screen
- Full-height QR scanner
- Real-time verification
- User information popup

### Admin Dashboard
- User statistics
- Complete user list
- Real-time data updates

---

## 🎯 Theme & Branding

### Color Palette
- **Primary**: Indigo (#6366F1)
- **Secondary**: Emerald (#10B981)
- **Accent**: Amber (#F59E0B)
- **Error**: Red (#EF4444)

### Typography
- **Headlines**: Poppins Bold (24-32px)
- **Body**: Inter Medium (14-16px)
- **Labels**: Poppins Semi-bold (12-14px)

### App Icons
- Modern gradient design
- Generated in all required sizes:
  - Android: 48x48 to 192x192 px
  - iOS: 20x20 to 1024x1024 px

### Documentation
- `DESIGN_SYSTEM.md` - Complete design system
- `BRANDING.md` - Brand guidelines
- `UI_ENHANCEMENT_SUMMARY.md` - UI improvements

---

## 🔧 Installation

### Prerequisites
- Flutter SDK (3.0.0+)
- Dart SDK
- Android Studio or Xcode
- Firebase project setup

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd identity_prototype
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` (Android)
   - Add your `GoogleService-Info.plist` (iOS)

4. **Run the app**
   ```bash
   flutter run
   ```

### Generate App Icons
```bash
python generate_icons.py
```

---

## 📦 Dependencies

```yaml
# Core
flutter: sdk platform
firebase_core: ^2.24.0
firebase_auth: ^4.15.0
cloud_firestore: ^4.15.0

# Features
mobile_scanner: ^3.5.5
qr_flutter: ^4.1.0

# Storage
hive: ^2.2.3
hive_flutter: ^1.1.0

# Security
crypto: ^3.0.3

# Design
google_fonts: ^6.1.0
flutter_svg: ^2.0.7
font_awesome_flutter: ^10.6.1
```

---

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/
│   └── app_theme.dart        # Theme configuration
├── screens/
│   ├── home_screen.dart
│   ├── user_request_screen.dart
│   ├── user_screen.dart
│   ├── scanner_screen.dart
│   ├── issuer_login_screen.dart
│   ├── issuer_screen.dart
│   └── admin_dashboard.dart
├── widgets/
│   ├── custom_widgets.dart   # Reusable components
│   └── app_shell.dart        # Main app scaffold
├── services/
│   └── ...
├── utils/
│   ├── ui_helper.dart
│   └── ...
└── models/
    └── ...

assets/
├── app_icon.svg              # Brand icon
└── sounds/
    └── ...
```

---

## 🎯 Usage Examples

### Using ModernCard
```dart
ModernCard(
  title: "User Verification",
  subtitle: "Verify and authenticate users",
  icon: Icons.verified_user,
  gradient: AppTheme.primaryGradient,
  onTap: () { /* action */ }
)
```

### Using BeautifulButton
```dart
BeautifulButton(
  label: "Save",
  icon: Icons.save,
  onPressed: () { /* action */ },
  isLoading: isLoading,
)
```

### Using Theme Colors
```dart
import 'package:identity_prototype/theme/app_theme.dart';

Container(
  color: AppTheme.primary,
  child: Text('Styled Text'),
)
```

---

## 🔐 Firebase Setup

### Firestore Collections
```
users/
├── qrHash (document ID)
├── name (string)
├── idNumber (string)
├── idType (string)
├── qr (string)
└── timestamp (date)
```

### Authentication
- Email/password authentication for admin
- User roles can be managed via Firestore custom claims

---

## 📱 Device Support

- ✅ Android 5.0+ (API 21+)
- ✅ iOS 11.0+
- ✅ Web (with build configuration)
- ✅ Tablets and large screens

---

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

---

## 📝 License

This project is proprietary software. All rights reserved.

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Commit with clear messages
5. Push to the branch
6. Create a Pull Request

---

## 📧 Support

For issues and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation files

---

## 📚 Documentation

- **Design System**: See [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md)
- **Branding Guidelines**: See [BRANDING.md](BRANDING.md)
- **UI Enhancements**: See [UI_ENHANCEMENT_SUMMARY.md](UI_ENHANCEMENT_SUMMARY.md)
- **Flutter Docs**: [flutter.dev](https://flutter.dev)
- **Firebase Docs**: [firebase.google.com](https://firebase.google.com)

---

## 🎉 Features Roadmap

### Current
- ✅ User verification
- ✅ QR code generation and scanning
- ✅ Admin dashboard
- ✅ Beautiful modern UI
- ✅ Firebase integration

### Planned
- [ ] Dark mode
- [ ] Multi-language support (i18n)
- [ ] Biometric authentication
- [ ] Offline mode
- [ ] Data export
- [ ] Advanced analytics
- [ ] Web portal
- [ ] Mobile app optimizations

---

**Version**: 1.0.0  
**Last Updated**: April 8, 2026  
**Status**: Active Development ✨

