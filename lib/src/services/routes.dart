import 'package:flutter/material.dart';
import 'package:search_test_api/src/views/edit_address_page.dart';
import 'package:search_test_api/src/views/list_address_page.dart';
import 'package:search_test_api/src/views/new_address_page.dart';

class RoutesApp {
  RoutesApp._();

  static Map<String, WidgetBuilder> routesList = {
    "/listAddressPage": (_) => const ListAddressPage(),
    "/newAddressPage": (_) => const NewAddressPage(),
    // "/editAddressPage": (_) => const EditAddressPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    var arguments = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case "/listAddressPage":
        return buildRoute(settings, const ListAddressPage());
      case "/newAddressPage":
        return buildRoute(settings, const NewAddressPage());
      case "/editAddressPage":
        return buildRoute(
            settings,
            EditAddressPage(
              address: arguments!['address'],
            ));
    }

    return null;
  }

  static MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
