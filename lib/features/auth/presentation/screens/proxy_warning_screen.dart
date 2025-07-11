import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techrar_task/core/network/proxy_detector.dart';
import 'package:techrar_task/core/network/proxy_state_provider.dart';
import 'package:techrar_task/features/tasks/presentation/providers/task_providers.dart';

class ProxyWarningScreen extends ConsumerWidget {
  final ProxyDetectionResult detectionResult;

  const ProxyWarningScreen({
    super.key,
    required this.detectionResult,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.amber,
              ),
              const SizedBox(height: 24),
              const Text(
                'Security Warning',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                detectionResult.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Check proxy status again
                  await ref.read(proxyStateProvider.notifier).checkProxy();

                  // If no proxy detected, refresh tasks
                  final currentProxyState = ref.read(proxyStateProvider);
                  if (currentProxyState.value?.isSecurityThreat == false) {
                    ref.invalidate(taskNotifierProvider);
                  }
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
