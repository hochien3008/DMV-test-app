# DMV Practice Test App

A comprehensive Flutter application designed to help users prepare for their DMV (Department of Motor Vehicles) driving test. The app provides practice tests with real-world questions, detailed explanations, and progress tracking.

## Features

### 🚦 **Multiple Test Categories**

- **Traffic Signs**: Learn about various traffic signs and their meanings
- **Road Rules**: Understand basic road rules and regulations
- **Safety**: Vehicle safety and emergency procedures
- **Parking**: Parking rules and regulations (Premium)
- **Emergency Procedures**: What to do in emergency situations (Premium)

### 📊 **Comprehensive Testing System**

- Multiple choice questions with detailed explanations
- Real-time progress tracking
- Score calculation and performance analytics
- Time tracking for each quiz attempt
- Pass/fail determination (70% passing threshold)

### 📱 **User-Friendly Interface**

- Modern, intuitive UI design
- Smooth navigation between questions
- Progress indicators and visual feedback
- Responsive design for various screen sizes
- Beautiful gradient backgrounds and animations

### 💾 **Data Management**

- Local database storage for quiz results
- History tracking of all quiz attempts
- Detailed result analysis
- Export and review capabilities

## Installation

### Prerequisites

- Flutter SDK (version 3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Setup Instructions

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd dmv_test
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate model files**

   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── models/           # Data models
│   ├── question.dart
│   ├── quiz_result.dart
│   └── category.dart
├── providers/        # State management
│   └── quiz_provider.dart
├── screens/          # UI screens
│   ├── home_screen.dart
│   ├── quiz_screen.dart
│   ├── result_screen.dart
│   └── results_screen.dart
├── services/         # Business logic
│   ├── database_service.dart
│   └── question_service.dart
├── widgets/          # Reusable UI components
└── utils/           # Utility functions

assets/
├── data/            # JSON data files
│   ├── categories.json
│   └── questions.json
├── images/          # Image assets
└── fonts/           # Custom fonts
```

## Usage

### Starting a Quiz

1. Open the app and select a test category from the home screen
2. Choose the number of questions (default: 10)
3. Begin answering questions one by one
4. Review explanations after each answer
5. Complete the quiz to see your results

### Reviewing Results

- View detailed score breakdown
- Check correct/incorrect answers
- Review time taken for each attempt
- Access quiz history from the home screen

### Navigation

- Use Previous/Next buttons to navigate between questions
- Exit quiz at any time (progress will be lost)
- Return to home screen after completing a quiz

## Technology Stack

- **Framework**: Flutter 3.8.1
- **Language**: Dart
- **State Management**: Provider
- **Database**: SQLite (via sqflite)
- **JSON Serialization**: json_annotation
- **UI**: Material Design 3

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  path: ^1.8.3
  http: ^1.1.0
  json_annotation: ^4.8.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  json_serializable: ^6.7.1
  build_runner: ^2.4.7
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Future Enhancements

- [ ] Add more question categories
- [ ] Implement image-based questions
- [ ] Add audio explanations
- [ ] Create study mode (no time limit)
- [ ] Add offline mode
- [ ] Implement user accounts and cloud sync
- [ ] Add social features (leaderboards, sharing)
- [ ] Create adaptive difficulty based on performance
- [ ] Add practice tests for specific states

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions, please open an issue in the GitHub repository or contact the development team.

---

**Note**: This app is designed for educational purposes and should not be used as the sole preparation method for DMV tests. Always refer to official DMV materials and guidelines for your specific state.
