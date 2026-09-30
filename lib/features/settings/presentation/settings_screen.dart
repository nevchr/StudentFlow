import 'package:flutter/material.dart';
import 'package:student_flow/shared/widgets/page_frame.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => const PageFrame(
    title: 'Settings & privacy',
    subtitle: 'Control your data and accessibility preferences.',
    child: Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_balance_outlined),
            title: Text('Connected accounts'),
            subtitle: Text('Demo mode — no bank connected'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Data and privacy'),
            subtitle: Text(
              'Real financial data is not stored in this milestone. Export, disconnect, and deletion flows are planned before live-bank testing.',
            ),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.accessibility_new),
            title: Text('Accessibility'),
            subtitle: Text(
              'System text scaling, TalkBack semantics, keyboard navigation, and reduced-motion navigation are enabled by design.',
            ),
          ),
        ],
      ),
    ),
  );
}
