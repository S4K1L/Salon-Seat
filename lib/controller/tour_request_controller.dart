import 'package:flutter_extension/data/model/tour_request_item_model.dart';
import 'package:get/get.dart';

class TourRequestController extends GetxController {
  TourRequestStatus _activeTab = TourRequestStatus.requested;
  final List<TourRequestItemModel> _items = <TourRequestItemModel>[
    TourRequestItemModel(
      id: '1',
      name: 'Sarah Johnson',
      listing: 'Luxe Beauty Suites',
      date: 'Mar 20, 2026',
      time: '3:00 PM',
      status: TourRequestStatus.requested,
    ),
    TourRequestItemModel(
      id: '2',
      name: 'Sarah Johnson',
      listing: 'Luxe Beauty Suites',
      date: 'Mar 20, 2026',
      time: '3:00 PM',
      status: TourRequestStatus.requested,
    ),
    TourRequestItemModel(
      id: '3',
      name: 'Sarah Johnson',
      listing: 'Luxe Beauty Suites',
      date: 'Mar 20, 2026',
      time: '3:00 PM',
      status: TourRequestStatus.confirmed,
    ),
    TourRequestItemModel(
      id: '4',
      name: 'Sarah Johnson',
      listing: 'Luxe Beauty Suites',
      date: 'Mar 20, 2026',
      time: '3:00 PM',
      status: TourRequestStatus.confirmed,
    ),
  ];

  TourRequestStatus get activeTab => _activeTab;
  List<TourRequestItemModel> get filteredItems =>
      _items.where((e) => e.status == _activeTab).toList();

  void changeTab(TourRequestStatus status) {
    if (_activeTab == status) return;
    _activeTab = status;
    update();
  }

  void acceptRequest(TourRequestItemModel item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index == -1) return;
    _items[index] = _items[index].copyWith(status: TourRequestStatus.confirmed);
    _activeTab = TourRequestStatus.confirmed;
    update();
  }

  void rejectRequest(TourRequestItemModel item) {
    _items.removeWhere((e) => e.id == item.id);
    update();
  }
}
