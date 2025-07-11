import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techrar_task/core/config/dependency_injection.dart';
import 'package:techrar_task/core/network/proxy_detector.dart';

part 'proxy_state_provider.g.dart';

@riverpod
class ProxyState extends _$ProxyState {
  @override
  Future<ProxyDetectionResult> build() async {
    return getIt<ProxyDetector>().checkForProxyAndVpn();
  }

  Future<void> checkProxy() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => getIt<ProxyDetector>().checkForProxyAndVpn());
  }
}
