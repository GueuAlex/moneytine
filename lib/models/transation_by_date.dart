class DataByDate<T> {
  DataByDate({
    required this.date,
    required this.data,
  });
  final DateTime date;
  final List<T> data;
}
