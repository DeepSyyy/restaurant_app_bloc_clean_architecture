abstract class RemoteSearchRestaurantEvent {
  const RemoteSearchRestaurantEvent();
}

class RemoteSearchRestaurant extends RemoteSearchRestaurantEvent {
  final String query;
  const RemoteSearchRestaurant({required this.query});
}
