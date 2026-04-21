enum ListingStatus { active, paused, draft, pending }

class ListingItem {
  const ListingItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.status,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final ListingStatus status;

  ListingItem copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? location,
    String? price,
    ListingStatus? status,
  }) {
    return ListingItem(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      location: location ?? this.location,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}
