import 'package:flutter/material.dart';

import '../domain/model/location.dart';

class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({
    super.key,
    required this.locations,
    required this.onSearch,
  });
  final List<Location> locations;
  final Function(List<Location>) onSearch;

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  late List<Location> filteredLocation;

  @override
  void initState() {
    filteredLocation = widget.locations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 16),
      child: SearchBar(
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16)),
          onChanged: (query) {
            filter(query);
          },
          leading: const Icon(Icons.search)
      ),
    );
  }

  void filter(String query) {
    setState(() {
      filteredLocation = widget.locations
          .where((location) =>
          location.name.trim().toLowerCase().contains(query.toLowerCase()))
          .toList();
      widget.onSearch(filteredLocation);
    });
  }
}
