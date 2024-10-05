class Pagination<T> {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<T> results;

  Pagination({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });
}
