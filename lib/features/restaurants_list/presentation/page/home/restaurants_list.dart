import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rest_app_bloc_sm/domain/entities/restaurant_entity.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_bloc.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_event.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/bloc/restaurant/remote/remote_restaurant_state.dart';
import 'package:rest_app_bloc_sm/features/restaurants_list/presentation/widget/restaurant_widget.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_bloc.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_event.dart';
import 'package:rest_app_bloc_sm/features/search_restaurants/presentation/bloc/remote/remote_search_state.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  bool isSearching = false;

  String lastSearch = '';

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      context
          .read<RemoteSearchRestaurantBloc>()
          .add(RemoteSearchRestaurant(query: query));
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      title: Text(
        'Restaurant List',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  _buildSearchBar() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            lastSearch = controller.text;
            return CupertinoSearchTextField(
              controller: controller,
              onSubmitted: _onSearchSubmitted,
              placeholder: 'Search restaurant',
              onSuffixTap: () {
                controller.clear();
                setState(() {
                  isSearching = false;
                });
              },
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          },
        ));
  }

  _buildBody() {
    return isSearching
        ? RefreshIndicator(
            onRefresh: () async {
              context.read<RemoteSearchRestaurantBloc>().add(
                    RemoteSearchRestaurant(query: lastSearch),
                  );
            },
            child: BlocBuilder<RemoteSearchRestaurantBloc,
                RemoteSearchRestaurantState>(
              builder: (_, searchState) {
                if (searchState is RemoteSearchRestaurantLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (searchState is RemoteSearchRestaurantError) {
                  return const Center(child: Icon(Icons.refresh));
                }
                if (searchState is RemoteSearchRestaurantDone) {
                  return _buildRestaurantList(searchState.restaurants!);
                }
                if (searchState is RemoteSearchRestaurantEmpty) {
                  return const Center(child: Text('No data found'));
                }
                return const SizedBox();
              },
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              context.read<RemoteRestaurantBloc>().add(
                    const RemoteRestaurantFetch(),
                  );
            },
            child: BlocBuilder<RemoteRestaurantBloc, RemoteRestaurantState>(
              builder: (_, state) {
                if (state is RemoteRestaurantLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is RemoteRestaurantError) {
                  return const Center(child: Icon(Icons.refresh));
                }
                if (state is RemoteRestaurantDone) {
                  return _buildRestaurantList(state.restaurants!);
                }
                return const SizedBox();
              },
            ),
          );
  }

  Widget _buildRestaurantList(List<RestaurantsEntity> restaurants) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return RestaurantCard(
          image: restaurants[index].pictureId!,
          restaurantName: restaurants[index].name!,
          restaurantLocation: restaurants[index].city!,
          restaurantRating: restaurants[index].rating!,
          restaurantDescription: restaurants[index].description!,
          restaurantId: restaurants[index].id!,
        );
      },
      itemCount: restaurants.length,
    );
  }
}
