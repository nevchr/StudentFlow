import 'package:flutter/material.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({
    required this.title,
    required this.child,
    this.subtitle,
    this.actions = const [],
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                if (subtitle != null) ...[
                  Text(subtitle!, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
