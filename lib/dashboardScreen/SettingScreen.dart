import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          const Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: true,
            onChanged: (val) {},
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: const Text('English'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),

          const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Traffic Alerts'),
            value: true,
            onChanged: (val) {},
          ),
          ListTile(
            title: const Text('Alert Sensitivity'),
            subtitle: const Text('High'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),

          const Text('Device', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            title: const Text('Connected Device'),
            subtitle: const Text('Iotraffix Module #A123'),
            trailing: const Icon(Icons.info_outline),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Calibrate Device'),
            trailing: const Icon(Icons.build),
            onTap: () {},
          ),
          const Divider(),

          const Text('Emergency', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            title: const Text('Manage Emergency Contacts'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text('Enable Auto SOS'),
            value: false,
            onChanged: (val) {},
          ),
          const Divider(),

          const Text('Help & Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            title: const Text('User Guide'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Contact Support'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}