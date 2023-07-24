class Device {
  final String id;
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final List<String> images;
  final String defaultImage;
  final String listingLocation;
  final String make;
  final String marketingName;
  final String mobileNumber;
  final String model;
  final bool verified;
  final String status;
  final String listingDate;
  final String deviceRam;
  final String createdAt;
  final String listingId;
  final int listingNumPrice;
  final String listingState;

  Device({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingLocation,
    required this.make,
    required this.marketingName,
    required this.mobileNumber,
    required this.model,
    required this.verified,
    required this.status,
    required this.listingDate,
    required this.deviceRam,
    required this.createdAt,
    required this.listingId,
    required this.listingNumPrice,
    required this.listingState,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['_id'] ?? '',
      deviceCondition: json['deviceCondition'] ?? '',
      listedBy: json['listedBy'] ?? '',
      deviceStorage: json['deviceStorage'] ?? '',
      images: List<String>.from(
          (json['images'] ?? []).map((e) => e['fullImage'] ?? '')),
      defaultImage: json['defaultImage']['fullImage'] ?? '',
      listingLocation: json['listingLocation'] ?? '',
      make: json['make'] ?? '',
      marketingName: json['marketingName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      model: json['model'] ?? '',
      verified: json['verified'] ?? false,
      status: json['status'] ?? '',
      listingDate: json['listingDate'] ?? '',
      deviceRam: json['deviceRam'] ?? '',
      createdAt: json['createdAt'] ?? '',
      listingId: json['listingId'] ?? '',
      listingNumPrice: json['listingNumPrice'] ?? 0,
      listingState: json['listingState'] ?? '',
    );
  }
}
