import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailAlerts = true;
  bool _smsAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Portal System Settings")),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          SwitchListTile(
            title: const Text("Enable Email Alerts"),
            subtitle: const Text("Receive email notifications for critical incidents"),
            value: _emailAlerts,
            onChanged: (val) => setState(() => _emailAlerts = val),
          ),
          SwitchListTile(
            title: const Text("Enable SMS Alerts"),
            subtitle: const Text("Receive priority SMS diagnostics for major failures"),
            value: _smsAlerts,
            onChanged: (val) => setState(() => _smsAlerts = val),
          ),
        ],
      ),
    );
  }
}