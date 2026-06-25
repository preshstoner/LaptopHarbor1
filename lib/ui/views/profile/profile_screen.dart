import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/data/data.dart';
import 'package:flutter_parcel_app/models/models.dart';
import 'package:flutter_parcel_app/ui/views/views.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  String name = "Precious Isitor";
  String email = "user@email.com";
  String memberSince = "2024";

  void _changeProfilePicture(){
    //TODO: implement image picker logic
  }

  void _editPersonalInfo(){
    //TODO: open a form to edit name/email
  }

  void _logout(){
    //TODO: clear auth token and navigate to login
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Profile picture + info
            GestureDetector(
              onTap: _changeProfilePicture,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.yellow,
                child: const Text("NBA", style: TextStyle(color: Colors.black, fontSize: 24)),
              ),
            ),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(email),
            Text("Member since $memberSince", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatBox(label: "Orders", value: "5"),
                _StatBox(label: "Wishlist", value: "12"),
                _StatBox(label: "Reviews", value: "3"),
              ],
            ),
            const SizedBox(height: 20),

            //Menu options
            _MenuOption(icon: Icons.shopping_bag, label: "My orders", onTap: () {}),
            _MenuOption(icon: Icons.location_on, label: "Saved addresses", onTap: () {}),
            _MenuOption(icon: Icons.edit, label: "Edit personal info", onTap: _editPersonalInfo),
            _MenuOption(icon: Icons.notifications, label: "Notifications", onTap: () {}),
            _MenuOption(icon: Icons.settings, label: "Settings", onTap: () {}),
            _MenuOption(icon: Icons.help, label: "Help & support", onTap: () {}),
            _MenuOption(
              icon: Icons.logout,
              label: "Logout",
              color: Colors.red,
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget{
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label),
        ],
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuOption(
      {required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black),
      title: Text(label, style: TextStyle(color: color ?? Colors.black)),
      onTap: onTap,
    );
  }
}