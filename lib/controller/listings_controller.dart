import 'package:get/get.dart';
import 'package:flutter_extension/data/model/listing_item_model.dart';

class ListingsController extends GetxController {
  int _activeFilterIndex = 0;
  final List<ListingItem> _allListings = <ListingItem>[..._seedListings];

  int get activeFilterIndex => _activeFilterIndex;

  static const List<String> _filterTitles = <String>[
    'Active',
    'Paused',
    'Draft',
    'Pending',
  ];

  static const List<ListingItem> _seedListings = <ListingItem>[
    ListingItem(
      id: 'listing_1',
      imageUrl:
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=900&q=80',
      title: 'Luxury Salon\nStation',
      location: 'Downtown, Los Angeles',
      price: '\$500/month',
      status: ListingStatus.active,
    ),
    ListingItem(
      id: 'listing_2',
      imageUrl:
          'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=900&q=80',
      title: 'Modern Chair\nRental',
      location: 'Beverly Hills',
      price: '\$650/mo',
      status: ListingStatus.active,
    ),
    ListingItem(
      id: 'listing_3',
      imageUrl:
          'https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?auto=format&fit=crop&w=900&q=80',
      title: 'Boutique Salon\nSpace',
      location: 'Santa Monica',
      price: '\$450/mo',
      status: ListingStatus.active,
    ),
    ListingItem(
      id: 'listing_4',
      imageUrl:
          'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?auto=format&fit=crop&w=900&q=80',
      title: 'Downtown Barber\nBooth',
      location: 'Hollywood',
      price: '\$380/mo',
      status: ListingStatus.paused,
    ),
  ];

  List<String> get filters {
    final active = _countByStatus(ListingStatus.active);
    final paused = _countByStatus(ListingStatus.paused);
    final draft = _countByStatus(ListingStatus.draft);
    final pending = _countByStatus(ListingStatus.pending);
    return <String>[
      '${_filterTitles[0]} ($active)',
      '${_filterTitles[1]} ($paused)',
      '${_filterTitles[2]} ($draft)',
      '${_filterTitles[3]} ($pending)',
    ];
  }

  List<ListingItem> get visibleListings {
    final selectedStatus = switch (_activeFilterIndex) {
      0 => ListingStatus.active,
      1 => ListingStatus.paused,
      2 => ListingStatus.draft,
      _ => ListingStatus.pending,
    };
    return _allListings.where((item) => item.status == selectedStatus).toList();
  }

  void onFilterTap(int index) {
    if (_activeFilterIndex == index) return;
    _activeFilterIndex = index;
    update();
  }

  int _countByStatus(ListingStatus status) =>
      _allListings.where((item) => item.status == status).length;

  void pauseListing(String id) {
    final index = _allListings.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final item = _allListings[index];
    if (item.status == ListingStatus.paused) return;
    _allListings[index] = item.copyWith(status: ListingStatus.paused);
    update();
  }

  void deleteListing(String id) {
    _allListings.removeWhere((item) => item.id == id);
    update();
  }

  void updateListing(ListingItem updatedItem) {
    final index = _allListings.indexWhere((item) => item.id == updatedItem.id);
    if (index == -1) return;
    _allListings[index] = updatedItem;
    update();
  }
}
