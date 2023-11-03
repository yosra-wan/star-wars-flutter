class Item {
  final String? producer;
  final String? director;
  final String title;
  final String? opening_crawl;
  final String? release_date;

  const Item(
      {this.producer,
      this.director,
      required this.title,
      this.opening_crawl,
      this.release_date});
}
