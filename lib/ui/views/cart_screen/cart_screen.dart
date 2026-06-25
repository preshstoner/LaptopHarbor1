import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/data/data.dart';
import 'package:flutter_parcel_app/models/models.dart';
import 'package:flutter_parcel_app/ui/views/views.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';

class CartScreen extends StatefulWidget{
  final Parcel selectedParcel;
  final DeliveryMethod selectedDeliverymethod;

  const CartScreen ({
    super.key,
    required this.selectedParcel,
    required this.selectedDeliverymethod,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>{
  final List<Map<String, dynamic>> cartItems = [
    {'name': 'Dell XPS 15', 'price': 85000, 'quantity': 1},
    {'name': 'Logitech MX Master 3', 'price': 45000, 'quantity': 2},
    {'name': 'Laptop Backpack 15.6"', 'price': 20500, 'quantity': 1},
  ];

  double shippingFee = 5000;
  double taxRate = 0.075;

  void _updateQuantity(int index, int change){
    setState(() {
      cartItems[index]['quantity'] += change;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

  double get tax => subtotal * taxRate;

  double get total => subtotal + shippingFee + tax;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index){
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.laptop),
                    title: Text(item['name']),
                    subtitle: Text('₦${item['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _updateQuantity(index, -1),
                        ),
                        Text('${item['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _updateQuantity(index, 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //Promo code section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter promo code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Apply')),
              ],
            ),
          ),

          //Summary section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _SummaryRow(label: 'Subtotal', value: subtotal),
                _SummaryRow(label: 'Shipping fee', value: shippingFee),
                _SummaryRow(label: 'Tax (7.5%)', value: tax),
                const Divider(),
                _SummaryRow(label: 'Total', value: total, bold: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ParcelCheckboxScreen(
                          parcel: widget.selectedParcel,
                          deliveryMethod: widget.selectedDeliverymethod,
                        ),
                      ),
                    );
                  },
                  child: const Text('Proceed to checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget{
  final String label;
  final double value;
  final bool bold;
  const _SummaryRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text('₦${value.toStringAsFixed(0)}',
            style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}