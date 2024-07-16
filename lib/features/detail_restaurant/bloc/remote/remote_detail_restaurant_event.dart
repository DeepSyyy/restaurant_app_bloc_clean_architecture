abstract class RemoteDetailRestaurantEvent {
  const RemoteDetailRestaurantEvent();
}

class RemoteDetailRestaurantFetch extends RemoteDetailRestaurantEvent {
  final String id;
  const RemoteDetailRestaurantFetch({required this.id});
}
