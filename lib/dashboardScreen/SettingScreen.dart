import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSectionTitle('General'),
            _buildSettingCard([
              _buildSwitchTile('Dark Mode', Icons.dark_mode, true, (val) {}),
              _buildListTile('Language', 'English', Icons.language, () {}),
            ]),

            _buildSectionTitle('Notifications'),
            _buildSettingCard([
              _buildSwitchTile('Traffic Alerts', Icons.traffic, true, (val) {}),
              _buildListTile('Alert Sensitivity', 'High', Icons.warning, () {}),
            ]),

            _buildSectionTitle('Device'),
            _buildSettingCard([
              _buildListTile('Connected Device', 'Iotraffix Module #A123',
                  Icons.devices, () {}),
              _buildListTile('Calibrate Device', '', Icons.build, () {}),
            ]),

            _buildSectionTitle('Emergency'),
            _buildSettingCard([
              _buildListTile('Manage Emergency Contacts', '', Icons.contacts,
                      () {}),
              _buildSwitchTile('Enable Auto SOS', Icons.sos, false, (val) {}),
            ]),

            _buildSectionTitle('Help & Support'),
            _buildSettingCard([
              _buildListTile('User Guide', '', Icons.book, () {}),
              _buildListTile('Contact Support', '', Icons.support_agent, () {}),
              _buildListTile('Privacy Policy', '', Icons.privacy_tip, () {}),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3F74FF),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Card(
      color: Color(0xFF3F74FF),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: const TextStyle(color: Colors.white70))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(String title, IconData icon, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,
      tileColor: Colors.transparent,
    );
  }
}
