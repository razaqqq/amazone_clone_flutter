class ReviewModul {
  final String senderName;
  final String description;
  final int rating;

  const ReviewModul(
      {required this.senderName,
      required this.description,
      required this.rating});

  factory ReviewModul.getModulFromJson({required Map<String, dynamic> json}) {
    return ReviewModul(
        senderName: json['senderName'],
        description: json['description'],
        rating: json['rating']);
  }

  Map<String, dynamic> getJson() => {
        'senderName': senderName,
        'description': description,
        'rating': rating,
      };
}
