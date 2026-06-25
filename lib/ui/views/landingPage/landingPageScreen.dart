import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/data/data.dart';
import 'package:flutter_parcel_app/models/models.dart';
import 'package:flutter_parcel_app/ui/views/views.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';

class LandingPageScreen extends StatelessWidget{
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Search bar
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search laptops...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Flash Sale banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child:
              Row(
                children: [
                  Expanded(
                      child: Text(
                        'Flash Sale\nUp to 40% off gaming laptops',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Shop now'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            //Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _CategoryIcon(icon: Icons.work, label: 'Business'),
               _CategoryIcon(icon: Icons.sports_esports, label: 'Gaming'),
                _CategoryIcon(icon: Icons.palette, label: 'Creative'),
              ],
            ),
            const SizedBox(height: 24),

            // Feature section
            const Text(' Featured', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _LaptopCard(name: 'Dell XPS 15', price: '₦850,000', discount: '-20%', rating: 5),
            _LaptopCard(name: 'MacBook Air M2', price: '₦1,200,000', rating: 5),
          ],
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget{
  final IconData icon;
  final String label;
  const _CategoryIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class _LaptopCard extends StatelessWidget{
  final String name;
  final String price;
  final String? discount;
  final int rating;
  const _LaptopCard({required this.name, required this.price, this.discount, required this.rating});

  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.laptop),
        title: Text(name),
        subtitle: Text(price),
        trailing: discount != null ? Text(discount!, style: const TextStyle(color: Colors.red)) : null,
      ),
    );
  }
}