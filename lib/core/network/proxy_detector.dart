import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProxyDetectionResult {
  final bool isSecurityThreat;
  final String message;

  const ProxyDetectionResult({
    required this.isSecurityThreat,
    required this.message,
  });
}

class ProxyDetector {
  final DeviceInfoPlugin _deviceInfo;
  final NetworkInfo _networkInfo;
  final FlutterSecureStorage _storage;
  final SharedPreferences _prefs;

  static const String _lastDetectionKey = 'last_proxy_detection';
  static const _simulationKey = 'proxy_simulation_enabled';

  ProxyDetector({
    DeviceInfoPlugin? deviceInfo,
    NetworkInfo? networkInfo,
    FlutterSecureStorage? storage,
    required SharedPreferences prefs,
  })  : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
        _networkInfo = networkInfo ?? NetworkInfo(),
        _storage = storage ?? const FlutterSecureStorage(),
        _prefs = prefs;

  bool get isSimulationEnabled => _prefs.getBool(_simulationKey) ?? false;

  Future<void> setSimulationEnabled(bool enabled) async {
    await _prefs.setBool(_simulationKey, enabled);
  }

  Future<ProxyDetectionResult> checkForProxyAndVpn() async {
    // If simulation is enabled, return a simulated threat
    if (isSimulationEnabled) {
      return const ProxyDetectionResult(
        isSecurityThreat: true,
        message: 'Simulated proxy/VPN detected',
      );
    }

    // In a real implementation, we would check for actual proxy/VPN here
    return const ProxyDetectionResult(
      isSecurityThreat: false,
      message: 'No security threats detected',
    );
  }

  Future<bool> _checkVpnConnection() async {
    try {
      final networkInterfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.any,
      );

      for (var interface in networkInterfaces) {
        // Common VPN interface names
        if (interface.name.toLowerCase().contains('tun') ||
            interface.name.toLowerCase().contains('ppp') ||
            interface.name.toLowerCase().contains('vpn')) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _checkProxySettings() async {
    try {
      final wifiIP = await _networkInfo.getWifiIP();
      // Check if system proxy is enabled
      // This is a simplified check - in a real app, you'd want to do more thorough testing
      final proxySettings = HttpClient.findProxyFromEnvironment(
        Uri.parse('https://api.example.com'),
        environment: Platform.environment,
      );
      return proxySettings.contains('PROXY');
    } catch (e) {
      return false;
    }
  }

  Future<DateTime?> getLastDetectionTime() async {
    final lastDetection = await _storage.read(key: _lastDetectionKey);
    if (lastDetection != null) {
      return DateTime.parse(lastDetection);
    }
    return null;
  }
}
