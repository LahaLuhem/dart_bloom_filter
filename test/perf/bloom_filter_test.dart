import 'package:dart_bloom_filter/dart_bloom_filter.dart';
import 'package:test/test.dart';

import 'heavy_object.dart';

void main() {
  // 1_000_000_000 is infeasible for the Set-implementation while still feasible for Bloom-filters
  const testDataSize = 100_000_000;
  final testData = List.generate(testDataSize, (index) => index);

  group('Benchmark default Bloom-filter', () {
    final bloomFilter = BloomFilter<int>(testDataSize, 0.01);

    // ADD
    final stopwatch = Stopwatch()..start();
    bloomFilter.addAll(items: testData);
    stopwatch.stop();

    print('\nAdded ${testData.length} items in ${stopwatch.elapsedMilliseconds}ms');
    print(
      'Average: ${(stopwatch.elapsedMicroseconds / testData.length).toStringAsFixed(2)} μs per operation',
    );
    print(
      'Operations/sec: ${(testData.length / stopwatch.elapsedMilliseconds * 1000).toStringAsFixed(2)}',
    );

    // CONTAINS
    stopwatch
      ..reset()
      ..start();
    for (final item in testData) {
      bloomFilter.contains(item: item);
    }
    stopwatch.stop();

    print('\nChecked ${testData.length} items in ${stopwatch.elapsedMilliseconds}ms');
    print(
      'Average: ${(stopwatch.elapsedMicroseconds / testData.length).toStringAsFixed(2)} μs per operation',
    );
    print(
      'Operations/sec: ${(testData.length / stopwatch.elapsedMilliseconds * 1000).toStringAsFixed(2)}',
    );
  });

  group('Murmur default Bloom-filter', () {
    final bloomFilter = BloomFilter<int>.murmur(testDataSize, 0.01, 42);

    // ADD
    final stopwatch = Stopwatch()..start();
    bloomFilter.addAll(items: testData);
    stopwatch.stop();

    print('\nAdded ${testData.length} items in ${stopwatch.elapsedMilliseconds}ms');
    print(
      'Average: ${(stopwatch.elapsedMicroseconds / testData.length).toStringAsFixed(2)} μs per operation',
    );
    print(
      'Operations/sec: ${(testData.length / stopwatch.elapsedMilliseconds * 1000).toStringAsFixed(2)}',
    );

    // CONTAINS
    stopwatch
      ..reset()
      ..start();
    for (final item in testData) {
      bloomFilter.contains(item: item);
    }
    stopwatch.stop();

    print('\nChecked ${testData.length} items in ${stopwatch.elapsedMilliseconds}ms');
    print(
      'Average: ${(stopwatch.elapsedMicroseconds / testData.length).toStringAsFixed(2)} μs per operation',
    );
    print(
      'Operations/sec: ${(testData.length / stopwatch.elapsedMilliseconds * 1000).toStringAsFixed(2)}',
    );
  });

  // group('Set implementation', () {
  //   final set = <int>{};
  //
  //   stopwatch
  //     ..reset()
  //     ..start();
  //   set.addAll(testData);
  //   stopwatch.stop();
  //
  //   print('[SET] Added ${testData.length} items in ${stopwatch.elapsedMilliseconds}ms');
  //   print(
  //     '[SET] Average: ${(stopwatch.elapsedMicroseconds / testData.length).toStringAsFixed(2)} μs per operation',
  //   );
  //   print(
  //     '[SET] Operations/sec: ${(testData.length / stopwatch.elapsedMilliseconds * 1000).toStringAsFixed(2)}',
  //   );
  //
  //   stopwatch
  //     ..reset()
  //     ..start();
  //   for (final item in testData) {
  //     bloomFilter.contains(item: item);
  //   }
  //   stopwatch.stop();
  //
  //   print('\n[SET] Checked ${testData.length} items in ${stopwatch.elapsedMilliseconds}ms');
  //   print(
  //     '[SET] Average: ${(stopwatch.elapsedMicroseconds / testData.length).toStringAsFixed(2)} μs per operation',
  //   );
  //   print(
  //     '[SET] Operations/sec: ${(testData.length / stopwatch.elapsedMilliseconds * 1000).toStringAsFixed(2)}',
  //   );
  // });

  test('', () {}, skip: true);
}

// Can be used to switch out quickly without over-engineering
//ignore: unused_element
HeavyObject _heavyObject(int id) {
  final genList = List.filled(id, id);
  final genListString = genList.map((e) => e.toString()).toList(growable: false);

  return HeavyObject(
    id: id.toString(),
    tags: genListString,
    metadata: Map.fromIterables(genListString, genList),
    largeData: genList,
    createdAt: DateTime.now(),
  );
}
