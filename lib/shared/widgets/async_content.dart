import 'package:flutter/material.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Semantics(
      label: 'Loading financial information',
      child: const Padding(
        padding: EdgeInsets.all(48),
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

class ErrorContent extends StatelessWidget {
  const ErrorContent({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sync_problem, size: 40),
          const SizedBox(height: 12),
          Text(
            'We could not load your financial information.',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Check your connection and try again. Your saved data has not been changed.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
        ],
      ),
    ),
  );
}
