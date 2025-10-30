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

  group('Merge test', () {
    const expectedNumberOfElements = 10;
    const falsePositiveProbability = 0.001;
    final originalBF = BloomFilter<String>(expectedNumberOfElements, falsePositiveProbability)
      ..addAll(items: _defaultItems);
    final originalBFLength = originalBF.length;
    final newItems = ['bluetooth', 'usb', 'ethernet'];
    final newBF = BloomFilter<String>(expectedNumberOfElements, falsePositiveProbability)
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
