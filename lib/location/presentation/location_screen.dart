import 'package:deepbreath/countries/domain/model/country.dart';
import 'package:deepbreath/location/util/location_search_bar.dart';
import 'package:deepbreath/utils/error_view.dart';
import 'package:deepbreath/utils/resource.dart';
import 'package:deepbreath/utils/theme.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/blur_effect.dart';
import '../domain/model/location.dart';
import '../util/string_helper.dart';
import 'location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationController _locationController;
  late final Country _country;
  late List<Location> _filteredLocations;
  late List<Location> _locations;
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _locationController = Get.find<LocationController>();
    _country = Get.arguments["country"];
    _filteredLocations = [];
    _locations = [];
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final locationsStream = _locationController.getLocationsByCountryId(_country.id);
    await for (var resource in locationsStream) {
      if (resource is Success) {
        setState(() {
          _locations = (resource as Success).data;
          _filteredLocations = _locations;
        });
      } else if (resource is Error) {
        setState(() {
          _errorMessage = (resource as Error).message;
        });
      } else if (resource is Loading) {
        setState(() {
          _isLoading = (resource as Loading).isLoading;
        });
      }
    }
  }

  Future<void> _retry() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
      _locations = [];
      _filteredLocations = [];
    });
    await _loadLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: LocationsAppBarTitle(country: _country),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: DeepBreathColors.appBarBackground,
        flexibleSpace: const BlurEffect(),
      ),
      body: _errorMessage.isNotEmpty
          ? ErrorView(onRetry: _retry)
          : Stack(
              children: [
                SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _isLoading
                        ? const Center(heightFactor: 15, child: CircularProgressIndicator())
                        : Column(
                            children: [
                              const SizedBox(height: 65),
                              Padding(
                                padding: DeepBreathPaddings.smallHorizontalPadding,
                                child: LocationsListView(filteredLocations: _filteredLocations),
                              ),
                            ],
                          ),
                  ),
                ),
                SafeArea(
                  child: LocationSearchBar(
                    locations: _locations,
                    onSearch: (filtered) {
                      setState(() => _filteredLocations = filtered);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class LocationsListView extends StatelessWidget {
  const LocationsListView({super.key, required List<Location> filteredLocations})
      : _filteredLocations = filteredLocations;

  final List<Location> _filteredLocations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _filteredLocations.length,
      itemBuilder: (context, index) {
        final location = _filteredLocations[index];
        return LocationItem(
          location: location,
          onTap: () => Get.toNamed('/location_details_screen', arguments: {'location': location}),
        );
      },
    );
  }
}

class LocationsAppBarTitle extends StatelessWidget {
  const LocationsAppBarTitle({super.key, required Country country}) : _country = country;

  final Country _country;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: DeepBreathPaddings.mainEndPadding,
          child: Hero(
            tag: _country,
            child: Flag.fromString(_country.code, height: 30, width: 40, borderRadius: 4),
          ),
        ),
        Flexible(child: Text(_country.name, style: DeepBreathTextStyles.title)),
      ],
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem({super.key, required this.location, required this.onTap});

  final Location location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: DeepBreathPaddings.mainAllPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(location.name, style: DeepBreathTextStyles.subtitle),
              const SizedBox(height: 8),
              Row(
                children: [
                  _StatusBadge(
                    icon: location.isMobile ? Icons.directions_walk : Icons.location_on,
                    label: location.isMobile ? 'Mobile' : 'Fixed',
                    color: location.isMobile ? Colors.orange.shade700 : Colors.blue.shade700,
                  ),
                  const SizedBox(width: 6),
                  _StatusBadge(
                    icon: location.isMonitor ? Icons.verified : Icons.sensors,
                    label: location.isMonitor ? 'Official' : 'Low-cost',
                    color: location.isMonitor ? Colors.green.shade700 : Colors.grey.shade600,
                  ),
                ],
              ),
              if (location.owner?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                _MetaRow(icon: Icons.account_balance_outlined, text: location.owner!),
              ],
              if (location.city?.isNotEmpty == true) ...[
                const SizedBox(height: 4),
                _MetaRow(icon: Icons.location_city_outlined, text: location.city!),
              ],
              if (location.lastUpdated.isNotEmpty) ...[
                const SizedBox(height: 4),
                _MetaRow(
                  icon: Icons.schedule,
                  text: 'Updated ${transformDateFormat(location.lastUpdated)}',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey.shade500),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
