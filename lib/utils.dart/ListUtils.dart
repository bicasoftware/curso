import 'dart:collection';

List<E> generateInverse<E>(int from, int to, E generateInverse(int index)) {
  final result = List<E>();
  for (int i = from; i >= to; i--) {
    result.add(generateInverse(i));
  }

  return result;
}

List<E> generateInRange<E>(int from, int to, E generateInRange(int index)) {
  final result = List<E>();
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

Iterable distinct(Iterable i) {
  var map = new LinkedHashMap();
  i.forEach((x) { map[x] = true; });
  return map.keys;  // map.keys.toList() would free the map for GC.
}
