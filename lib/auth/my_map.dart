import 'dart:collection';

class MyMap<K, V> extends MapBase<K, V> {
  final Map<K, V> _innerMap;
  final V genericValue;
  MyMap(this.genericValue,this._innerMap);

  @override
  V? operator [](Object? key) {
    var realKey = key as K;
    if (_innerMap.keys.contains(realKey)) {
      return _innerMap[realKey];
    } else {
      return genericValue;
    }
  }
  @override
  void operator []=(K key, V value) {
    _innerMap[key] = value;
  }
  @override
  void clear() {
    _innerMap.clear();
  }
  @override
  Iterable<K> get keys => _innerMap.keys;

  @override
  V? remove(Object? key) => _innerMap.remove(key as K);
}
