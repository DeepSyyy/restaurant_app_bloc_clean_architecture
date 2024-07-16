import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_app_bloc_sm/config/routes/routes.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_bloc.dart';
import 'package:rest_app_bloc_sm/features/review_restaurant/bloc/remote/remote_post_review_bloc.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_bloc.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_event.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/page/home/restaurants_list.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_bloc.dart';
import 'package:rest_app_bloc_sm/injection_container.dart';

Future<void> main() async {
  await initializeDepedencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteRestaurantBloc>(
          create: (context) => sl<RemoteRestaurantBloc>()
            ..add(
              const RemoteRestaurantFetch(),
            ),
        ),
        BlocProvider<RemoteSearchRestaurantBloc>(
          create: (context) => sl<RemoteSearchRestaurantBloc>(),
        ),
        BlocProvider<RemoteDetailRestaurantBloc>(
          create: (context) => sl<RemoteDetailRestaurantBloc>(),
        ),
        BlocProvider<RemotePostReviewBloc>(
          create: (context) => sl<RemotePostReviewBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        onGenerateRoute: AppRoute.onGeneratedRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RestaurantList(),
      ),
    );
  }
}
