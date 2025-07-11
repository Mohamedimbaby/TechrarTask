# TechRar Task

A Flutter application with advanced security features including VPN/Proxy detection, environment-based configuration, and theme management.

## Features

### Security Features

#### VPN and Proxy Detection
The app implements a robust VPN and proxy detection system that:

1. **Real-time Detection**:
   - Monitors network configuration changes
   - Detects active VPN connections
   - Identifies proxy server usage
   - Checks for network spoofing attempts

2. **Detection Methods**:
   - HTTP Headers Analysis
   - DNS Leak Detection
   - Network Interface Monitoring
   - IP Address Verification

3. **Implementation Details**:
   ```dart
   class ProxyDetector {
     // Checks for VPN, Proxy, and other security threats
     Future<ProxyDetectionResult> checkForProxyAndVpn() async {
       // Network interface check
       // DNS resolution verification
       // HTTP header analysis
       // IP address validation
     }
   }
   ```

4. **Security Response**:
   - Displays warning screen on detection
   - Allows users to disable VPN/proxy
   - Provides retry mechanism
   - Maintains session security

### Theme Management

- Dynamic theme switching (Light/Dark mode)
- Environment-based theme configuration
- Customizable color schemes
- Persistent theme preferences

### Environment Configuration

The app uses environment-based configuration for different deployment scenarios:

1. **Environment Files**:
   - `.env`: Base configuration
   - `.env.development`: Development environment
   - `.env.production`: Production environment

2. **Configurable Values**:
   ```properties
   # API Configuration
   API_BASE_URL=https://api.example.com
   API_VERSION=v1

   # Theme Configuration
   PRIMARY_COLOR=0xFF6200EE
   SECONDARY_COLOR=0xFF03DAC6
   ERROR_COLOR=0xFFB00020

   # Asset Paths
   IMAGES_PATH=assets/images
   LOGO_PATH=assets/images/logo.png
   DEFAULT_AVATAR_PATH=assets/images/default_avatar.png
   ```

## Requirements

### Development Environment

1. **Flutter SDK**: ^3.2.3
2. **Dart**: ^3.2.3
3. **IDE**:
   - VS Code with Flutter extension, or
   - Android Studio with Flutter plugin

### Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.4.9
  auto_route: ^7.8.4
  get_it: ^7.6.4
  shared_preferences: ^2.2.2
  flutter_dotenv: ^5.1.0
```

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd techrar_task
   ```

2. **Environment Setup**:
   ```bash
   # Copy environment files
   cp .env.example .env
   cp .env.example .env.development
   cp .env.example .env.production

   # Customize environment values as needed
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run Code Generation**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Running the App

### Development Mode
```bash
flutter run --dart-define=FLUTTER_ENV=development
```

### Production Mode
```bash
flutter run --dart-define=FLUTTER_ENV=production
```

## Architecture

The app follows Clean Architecture principles with the following layers:

1. **Presentation Layer**:
   - Screens
   - Widgets
   - View Models

2. **Domain Layer**:
   - Use Cases
   - Entities
   - Repository Interfaces

3. **Data Layer**:
   - Repositories
   - Data Sources
   - Models

## Security Considerations

1. **VPN/Proxy Detection**:
   - Regular network status monitoring
   - Multiple detection methods for reliability
   - Graceful handling of false positives

2. **Data Security**:
   - Secure storage for sensitive data
   - Environment variable protection
   - Network security measures

3. **Error Handling**:
   - Graceful degradation
   - User-friendly error messages
   - Logging and monitoring

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
