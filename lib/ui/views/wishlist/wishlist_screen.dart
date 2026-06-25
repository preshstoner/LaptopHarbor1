import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/data/data.dart';
import 'package:flutter_parcel_app/models/models.dart';
import 'package:flutter_parcel_app/ui/views/views.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';

class WishListScreen extends StatelessWidget{
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context){
    final products = [
      {
        'name': 'MacBook Pro 14',
        'price': '₦1,500,000',
        'status': 'In stock',
        'action': 'Add to cart',
        'image': 'assets/images/macbook.png',
      },
      {
        'name': 'Asus ROG G15',
        'price': '₦980,000',
        'status': 'Low stock',
        'action': 'Add to cart',
        'image': 'assets/images/asus.png',
      },
      {
        'name': 'Lenovo Legion 5',
        'price': '₦890,000',
        'status': 'Out of stock',
        'action': 'Notify me',
        'image': 'assets/images/lenovo.png',
      },
      {
        'name': 'HP Spectre x360',
        'price': '₦720,000',
        'status': 'In stock',
        'action': 'Add to cart',
        'image': 'assets/images/hp.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist (4)'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          //Build a Parcel object from product data
          final parcel = Parcel(
            size: 'Medium',
            image: product['image']!,
            dimension: '14 inch',
            description: product['name']!,
          );

          //Provide a default DeliveryMethod
          final deliveryMethod = DeliveryMethod(
            deliveryMethod: 'Standard Delivery',
            duration: '3-5 days',
            image: 'assets/image/delivery.png',
          );
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.laptop),
              title: Text(product['name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['price']!),
                  Text(product['status']!,
                      style: TextStyle(
                        color: product['status'] == 'Out of stock'
                            ? Colors.red
                            : Colors.green,
                      )),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  if (product['action'] == 'Add to cart'){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CartScreen(
                              selectedParcel: parcel,
                              selectedDeliverymethod: deliveryMethod,
                          ),
                        ),
                    );
                  } else {
                    //Handle "Notify me" case
                  }
                },
                child: Text(product['action']!),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              // TODO: implement share wishlist
            },
            child: const Text(
              'Share wishlist',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.yellow,
                decoration: TextDecoration.underline,
              ),
            ),
          )
      ),
    );
  }
}