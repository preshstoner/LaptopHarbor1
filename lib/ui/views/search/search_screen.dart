import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/data/data.dart';
import 'package:flutter_parcel_app/models/models.dart';
import 'package:flutter_parcel_app/ui/views/views.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  RangeValues _priceRange = const RangeValues(50000, 150000);
  String? _selectedBrand;
  String? _selectedRam;
  String? _selectedStorage;
  String? _selectedSort;
  double _minRating = 4;

  final brands = ['Asus', 'Dell', 'HP', 'Apple'];
  final rams = ['8GB', '16GB', '32GB'];
  final storages = ['256GB', '512GB', '1TB'];
  final sorts = ['Price ↑', 'Price ↓', 'Rating', 'Newest'];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Search laptops')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Search bar
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search by model or brand...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Brand filter
            const Text('Brand', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: brands.map((b) {
                return ChoiceChip(
                  label: Text(b),
                  selected: _selectedBrand == b,
                  onSelected: (_) => setState(() => _selectedBrand = b),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            //Price Range
            const Text('Price range', style: TextStyle(fontWeight: FontWeight.bold)),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 200000,
              divisions: 20,
              labels: RangeLabels(
                '₦${_priceRange.start.round()}',
                '₦${_priceRange.end.round()}',
              ),
              onChanged: (values) => setState(() => _priceRange = values),
            ),
            const SizedBox(height: 20),

            // RAM filter
            const Text('RAM', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: rams.map((r) {
                return ChoiceChip(
                  label: Text(r),
                  selected: _selectedRam == r,
                  onSelected: (_) => setState(() => _selectedRam = r),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Storage filter
            const Text('Storage', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: storages.map((s) {
                return ChoiceChip(
                  label: Text(s),
                  selected: _selectedStorage == s,
                  onSelected: (_) => setState(() => _selectedStorage = s),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            //Rating filter
            const Text('Minimum rating', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _minRating,
              min: 1,
              max: 5,
              divisions: 4,
              label: '★ ${_minRating.round()} & up',
              onChanged: (val) => setState(() => _minRating = val),
            ),
            const SizedBox(height: 20),

            //Sort options
            const Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: sorts.map((s) {
                return ChoiceChip(
                  label: Text(s),
                  selected: _selectedSort == s,
                  onSelected: (_) => setState(() => _selectedSort == s),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            //Reset and Apply buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: (){
                    setState(() {
                      _selectedBrand = null;
                      _selectedRam = null;
                      _selectedStorage = null;
                      _selectedSort = null;
                      _priceRange = const RangeValues(0, 200000);
                      _minRating = 1;
                    });
                  },
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    //TODO: Apply filters to search results
                  },
                  child: const Text('Apply filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}