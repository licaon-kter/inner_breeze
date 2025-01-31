import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inner_breeze/widgets/breeze_bottom_nav.dart';
import 'package:inner_breeze/widgets/breeze_app_bar.dart';
import 'package:inner_breeze/widgets/breathing_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

Future<void> resetData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var tempo = 2.0;
  var round = 1;
  var volume = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BreezeAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 480,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [    
                Text('Breathing Configuration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                BreathingConfiguration(),
                SizedBox(height: 30),
          
                // General Settings Section
                Text('General Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(140, 50),
                  ),
                  child: Text(
                    "Tutorial",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    context.go('/guide/welcome');
                  },
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: resetData,
                  child: Text("Reset Data"),
                ),
                // Links Section
                SizedBox(height: 40),
                Text('Connect & Support', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    _buildIconLink(Icons.web, 'Website', 'https://naox.io/'),
                    _buildIconLink('assets/icons/github.svg', 'GitHub', 'https://github.com/naoxio'),
                    _buildIconLink('assets/icons/telegram.svg', 'Telegram', 'https://t.me/naoxio'),
                    _buildIconLink('assets/icons/twitter.svg', 'X Page', 'https://x.com/naox_io'),
                    _buildIconLink(Icons.monetization_on, 'Coindrop', 'https://coindrop.to/naox'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BreezeBottomNav(),
    );
  }
  Widget _buildIconLink(dynamic iconOrImagePath, String tooltip, String url) {
    return IconButton(
      icon: (iconOrImagePath is IconData) 
         ? Icon(iconOrImagePath, color: Colors.teal)
        : (iconOrImagePath.endsWith('.svg')
            ? SvgPicture.asset(iconOrImagePath, color: Colors.teal, width: 24, height: 24)
            : Image.asset(iconOrImagePath, color: Colors.teal, width: 24, height: 24)),
      tooltip: tooltip,
      onPressed: () => launchUrl(url as Uri),
    );
  }

}
