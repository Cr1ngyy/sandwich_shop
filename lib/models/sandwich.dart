class Sandwich {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  const Sandwich({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}
