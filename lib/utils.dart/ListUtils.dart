List<E> generateInverse<E>(int from, int to, E generateInverse(int index)) {
  final result = <E>[];
  for (int i = from; i >= to; i--) {
    result.add(generateInverse(i));
  }

  return result;
}

List<E> generateInRange<E>(int from, int to, E generateInRange(int index)) {
  final result = <E>[];
  for (int i = from; i <= to; i++) {
    result.add(generateInRange(i));
  }

  return result;
}

Iterable<int> range(int low, int high) sync* {
  for (int i = low; i < high; ++i) {
    yield i;
  }
}

String parseListAsQuotedString<T>(List<T> from) {
  return from.map((s) => "'$s'").join(",");
}
