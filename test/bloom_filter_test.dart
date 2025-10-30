import 'package:dart_bloom_filter/dart_bloom_filter.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  group('Contains test', () {
    final bloomFilter = BloomFilter<String>(10, 0.001)..addAll(items: _defaultItems);

    test('Element exists', () {
      final doesContain = bloomFilter.contains(item: 'wifi');
      doesContain.should.beTrue();
    });
    test('Element does not exist', () {
      final doesContain = bloomFilter.contains(item: 'bluetooth');
      doesContain.should.beFalse();
    });
  });
}

const _defaultItems = [
  'roti',
  'kapda',
  'makaan',
  'credit card',
  'wifi',
  'snacks',
  'ghar ki roti',
  'bahar ki boti',
];
