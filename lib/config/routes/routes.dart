import 'package:flutter/material.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/page/detail_restaurant.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/page/home/restaurants_list.dart';

class AppRoute {
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialPageRoute(const RestaurantList());
      case '/detail':
        final id = settings.arguments as String;
        return _materialPageRoute(DetailRestaurant(id: id));
      default:
        return _materialPageRoute(const Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        ));
    }
  }

  static Route<dynamic> _materialPageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
