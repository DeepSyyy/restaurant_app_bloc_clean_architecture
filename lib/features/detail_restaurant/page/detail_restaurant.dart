import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_bloc.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_event.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/bloc/remote/remote_detail_restaurant_state.dart';
import 'package:rest_app_bloc_sm/features/review_restaurant/bloc/remote/remote_post_review_bloc.dart';
import 'package:rest_app_bloc_sm/features/review_restaurant/bloc/remote/remote_post_review_event.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/widget/drink_card.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/widget/food_card.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/widget/post_review_widget.dart';
import 'package:rest_app_bloc_sm/features/detail_restaurant/widget/review_tile.dart';

class DetailRestaurant extends StatefulWidget {
  const DetailRestaurant({super.key, required this.id});
  final String id;

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  final _textEditingController = TextEditingController();
  @override
  void initState() {
    context
        .read<RemoteDetailRestaurantBloc>()
        .add(RemoteDetailRestaurantFetch(id: widget.id));
    super.initState();
  }

  _submitReview(BuildContext context) {
    final review = _textEditingController.text;
    if (review.isNotEmpty) {
      context.read<RemotePostReviewBloc>().add(
          RemotePostReview(id: widget.id, name: "JohnDoe", review: review));
      _textEditingController.clear();
      //refresh the detail restaurant
      setState(() {
        context
            .read<RemoteDetailRestaurantBloc>()
            .add(RemoteDetailRestaurantFetch(id: widget.id));
      });
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Review cannot be empty"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      title: Text(
        'Detail Restaurant',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<RemoteDetailRestaurantBloc>()
            .add(RemoteDetailRestaurantFetch(id: widget.id));
      },
      child:
          BlocBuilder<RemoteDetailRestaurantBloc, RemoteDetailRestaurantState>(
              builder: (_, state) {
        if (state is RemoteDetailRestaurantLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RemoteDetailRestaurantDone) {
          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://restaurant-api.dicoding.dev/images/large/${state.restaurant!.pictureId}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                state.restaurant!.name!,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    state.restaurant!.city!,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    state.restaurant!.rating.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                state.restaurant!.description!,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Menu",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Foods",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.restaurant!.menus!.foods!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FoodCard(
                          title: state.restaurant!.menus!.foods![index].name!),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Drinks",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.restaurant!.menus!.drinks!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DrinkCard(
                          title: state.restaurant!.menus!.drinks![index].name!),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Reviews",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              PostreviewComponent(
                  controller: _textEditingController,
                  handler: (reviewText) {
                    _submitReview(context);
                  }),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: state.restaurant!.customerReviews!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ReviewTile(
                          nama: state.restaurant!.customerReviews![index].name!,
                          review:
                              state.restaurant!.customerReviews![index].review!,
                          tanggal:
                              state.restaurant!.customerReviews![index].date!,
                        ),
                      );
                    }),
              )
            ],
          );
        } else if (state is RemoteDetailRestaurantError) {
          return const Center(child: Icon(Icons.refresh));
        }
        return const SizedBox();
      }),
    );
  }
}
