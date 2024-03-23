import 'package:flutter/material.dart';

import '../domain/model/country.dart';

class CountriesSearchBar extends StatefulWidget {
  const CountriesSearchBar({
    super.key,
    required this.countries,
    required this.onSearch,
  });
  final List<Country> countries;
  final Function(List<Country>) onSearch;

  @override
  State<CountriesSearchBar> createState() => _CountriesSearchBarState();
}

class _CountriesSearchBarState extends State<CountriesSearchBar> {
  late List<Country> filteredCountries;

  @override
  void initState() {
    filteredCountries = widget.countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SearchBar(
          hintText: "Search for a country...",
          backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xF1FFFAFF)),
          shadowColor: MaterialStateColor.resolveWith((states) => const Color(0x66000000)),
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16)
          ),
          onChanged: (query) {
            filter(query);
          },
          leading: const Icon(Icons.search)
      ),
    );
  }

  void filter(String query) {
    setState(() {
      filteredCountries = widget.countries
          .where((country) =>
          country.name.trim().toLowerCase().contains(
              query.trim().toLowerCase()
          )).toList();
      widget.onSearch(filteredCountries);
    });
  }
}
