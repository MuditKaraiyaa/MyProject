import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:xbridge/location_update/presentation/widget/geolocator_widget_state.dart';
import 'package:flutter/material.dart';

class GeolocatorWidget extends StatefulWidget {
  /// Creates a new GeolocatorWidget.
  const GeolocatorWidget({Key? key}) : super(key: key);

  /// Utility method to create a page with the Baseflow templating.
  static ExamplePage createPage() {
    return ExamplePage(
        Icons.location_on, (context) => const GeolocatorWidget(),);
  }

  @override
  GeolocatorWidgetState createState() => GeolocatorWidgetState();
}
