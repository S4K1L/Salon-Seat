/// Salon space listing shown to beauty professionals (browse / search / map).
class ProfessionalBrowseListing {
  const ProfessionalBrowseListing({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.priceLabel,
    required this.imageUrl,
    required this.description,
    required this.priceDetail,
    required this.rentalType,
    required this.mapLocationLabel,
    required this.latitude,
    required this.longitude,
    required this.ownerName,
    required this.ownerVerified,
    required this.availability,
    required this.amenities,
    required this.galleryUrls,
  });

  final String id;
  final String title;
  final String location;
  /// e.g. Chair, Suite, Booth
  final String category;
  final String priceLabel;
  final String imageUrl;
  final String description;
  final String priceDetail;
  final String rentalType;
  final String mapLocationLabel;
  final double latitude;
  final double longitude;
  final String ownerName;
  final bool ownerVerified;
  final String availability;
  final List<String> amenities;
  final List<String> galleryUrls;

  String get categoryKey => category.toLowerCase();
}

/// Shared demo data for professional flows.
final List<ProfessionalBrowseListing> kProfessionalBrowseListingsSeed = [
  ProfessionalBrowseListing(
    id: 'pb_1',
    title: 'Luxury Salon Station',
    location: 'Downtown, Los Angeles',
    category: 'Chair',
    priceLabel: '\$500/month',
    imageUrl:
        'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=800&q=80',
    description:
        'Spacious modern salon suite located in the heart of downtown. Perfect for hair stylists looking for flexible monthly leases. Includes access to all amenities and a professional environment.',
    priceDetail: '\$250 / month',
    rentalType: 'Chair Rental',
    mapLocationLabel: 'Downtown Dallas',
    latitude: 34.0522,
    longitude: -118.2437,
    ownerName: 'Luxe Beauty Suites',
    ownerVerified: true,
    availability: 'Immediate / Monthly Lease',
    amenities: [
      'Wi-Fi',
      'Parking',
      'Laundry',
      'Waiting Area',
      'Natural Light',
      'AC',
    ],
    galleryUrls: [
      'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=900&q=80',
    ],
  ),
  ProfessionalBrowseListing(
    id: 'pb_2',
    title: 'Modern Chair Rental',
    location: 'Beverly Hills',
    category: 'Chair',
    priceLabel: '\$650/month',
    imageUrl:
        'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=800&q=80',
    description:
        'Bright chair rental in a high-traffic Beverly Hills salon. Great foot traffic and premium clientele.',
    priceDetail: '\$650 / month',
    rentalType: 'Chair Rental',
    mapLocationLabel: 'Beverly Hills, CA',
    latitude: 34.0736,
    longitude: -118.4004,
    ownerName: 'Glamour Studio Co.',
    ownerVerified: true,
    availability: 'Immediate / Monthly Lease',
    amenities: ['Wi-Fi', 'Parking', 'AC', 'Waiting Area'],
    galleryUrls: [
      'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=900&q=80',
    ],
  ),
  ProfessionalBrowseListing(
    id: 'pb_3',
    title: 'Boutique Salon Space',
    location: 'Santa Monica',
    category: 'Suite',
    priceLabel: '\$500/month',
    imageUrl:
        'https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?auto=format&fit=crop&w=800&q=80',
    description:
        'Private suite with natural light, ideal for estheticians and lash artists. Quiet, professional setting.',
    priceDetail: '\$500 / month',
    rentalType: 'Suite Rental',
    mapLocationLabel: 'Santa Monica, CA',
    latitude: 34.0195,
    longitude: -118.4912,
    ownerName: 'Coastal Beauty Loft',
    ownerVerified: false,
    availability: 'Available next month',
    amenities: ['Wi-Fi', 'Natural Light', 'AC', 'Laundry'],
    galleryUrls: [
      'https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=900&q=80',
    ],
  ),
  ProfessionalBrowseListing(
    id: 'pb_4',
    title: 'Downtown Barber Booth',
    location: 'Hollywood',
    category: 'Booth',
    priceLabel: '\$380/month',
    imageUrl:
        'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?auto=format&fit=crop&w=800&q=80',
    description:
        'Compact booth setup perfect for barbers. Shared amenities and flexible lease terms.',
    priceDetail: '\$380 / month',
    rentalType: 'Booth Rental',
    mapLocationLabel: 'Hollywood, CA',
    latitude: 34.0928,
    longitude: -118.3287,
    ownerName: 'Urban Cuts Collective',
    ownerVerified: true,
    availability: 'Immediate / Monthly Lease',
    amenities: ['Wi-Fi', 'Parking', 'Waiting Area'],
    galleryUrls: [
      'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?auto=format&fit=crop&w=900&q=80',
    ],
  ),
];

List<ProfessionalBrowseListing> filterProfessionalListings({
  required List<ProfessionalBrowseListing> source,
  int categoryIndex = 0,
  String query = '',
}) {
  const keys = ['all', 'chair', 'suite', 'booth'];
  final key = keys[categoryIndex.clamp(0, keys.length - 1)];
  var list = source;
  if (key != 'all') {
    list = list.where((e) => e.categoryKey == key).toList();
  }
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return list;
  return list
      .where(
        (e) =>
            e.title.toLowerCase().contains(q) ||
            e.location.toLowerCase().contains(q) ||
            e.mapLocationLabel.toLowerCase().contains(q),
      )
      .toList();
}
