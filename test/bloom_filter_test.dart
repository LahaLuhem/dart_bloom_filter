import 'package:dart_bloom_filter/dart_bloom_filter.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  group('Contains test', () {
    final bloomFilter = BloomFilter<String>(_defaultItems.length, 0.001)
      ..addAll(items: _defaultItems);

    test('Element exists', () {
      final doesContain = bloomFilter.contains(item: 'wifi');
      doesContain.should.beTrue();
    });
    test('Element does not exist', () {
      final doesContain = bloomFilter.contains(item: 'bluetooth');
      doesContain.should.beFalse();
    });
  });

  group('Merge test', () {
    const falsePositiveProbability = 0.001;
    const newItems = ['bluetooth', 'usb', 'ethernet'];
    final combinedExpectedLength = _defaultItems.length + newItems.length;

    final originalBF = BloomFilter<String>(combinedExpectedLength, falsePositiveProbability)
      ..addAll(items: _defaultItems);
    final originalBFLength = originalBF.length;
    final newBF = BloomFilter<String>(combinedExpectedLength, falsePositiveProbability)
      ..addAll(items: newItems);
    originalBF.merge(newBF);

    test('Merging is length-commutative', () {
      originalBF.length.should.be(originalBFLength + newBF.length);
    });
    test('Merging is element-commutative', () {
      newItems.should.all((item) => originalBF.contains(item: item));
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
