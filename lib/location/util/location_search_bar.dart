import 'package:deepbreath/utils/theme.dart';
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
      padding: DeepBreathPaddings.searchBarOuterPadding,
      child: SearchBar(
          hintText: "Search for a location...",
          backgroundColor: MaterialStateColor.resolveWith((states) =>
              DeepBreathColors.searchBarBackground
          ),
          shadowColor: MaterialStateColor.resolveWith((states) =>
              DeepBreathColors.searchBarShadow
          ),
          padding: DeepBreathPaddings.searchBarInnerPadding,
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
          location.name.trim().toLowerCase().contains(
              query.trim().toLowerCase()
          )).toList();
      widget.onSearch(filteredLocation);
    });
  }
}
