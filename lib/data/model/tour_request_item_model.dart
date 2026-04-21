enum TourRequestStatus { requested, confirmed }

class TourRequestItemModel {
  TourRequestItemModel({
    required this.id,
    required this.name,
    required this.listing,
    required this.date,
    required this.time,
    required this.status,
  });

  final String id;
  final String name;
  final String listing;
  final String date;
  final String time;
  final TourRequestStatus status;

  TourRequestItemModel copyWith({
    String? id,
    String? name,
    String? listing,
    String? date,
    String? time,
    TourRequestStatus? status,
  }) {
    return TourRequestItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      listing: listing ?? this.listing,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}
