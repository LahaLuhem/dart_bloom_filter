import 'dart:math';

import 'package:bit_array/bit_array.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:murmurhash/murmurhash.dart';

import 'bit_array_serializer.dart';
import 'bloom_filter_base.dart';

part 'bloom_filter.g.dart';

@JsonSerializable()
final class BloomFilter<T> extends BloomFilterBase<T> {
  @BitArraySerializer()
  late final BitArray bitArray;

  /// total size of the bit array
  late final int arraySize;

  /// seed to be used for the hashing algorithm
  final int hashSeed;

  /// sets to true if murmur hash is being used
  final bool murmur;

  /// number of elements user is expecting to add to the filter
  final int expectedNumberOfElements;

  /// expected false positive rate
  final double falsePositiveProbability;

  /// ceil(-log2(false prob))
  final int numberOfHashes;

  /// number of elements add to the filter since generation
  var _numberOfElements = 0;

  /// Returns the number of elements add to the filter since generation
  int get length => _numberOfElements;

  BloomFilter(
    this.expectedNumberOfElements,
    this.falsePositiveProbability, {
    this.hashSeed = 0,
    this.murmur = false,
  }) : numberOfHashes = (-(log(falsePositiveProbability) / log(2))).ceil() {
    final constant = (-(log(falsePositiveProbability) / log(2))).ceil() / log(2);

    arraySize = (constant * expectedNumberOfElements).ceil();
    bitArray = BitArray(arraySize);
  }

  /// Bloom Filter that uses murmur hashing algorithm
  factory BloomFilter.murmur(
    int expectedNumberOfElements,
    double falsePositiveProbability,
    int hashSeed,
  ) => BloomFilter(
    expectedNumberOfElements,
    falsePositiveProbability,
    hashSeed: hashSeed,
    murmur: true,
  );

  /// sets the required bit to true
  @override
  void add({required T item}) {
    bitArray.setBit(_getHash(item: item) % arraySize);
    _numberOfElements++;
  }

  @override
  void addAll({required List<T> items}) {
    for (final item in items) {
      bitArray.setBit(_getHash(item: item) % arraySize);
      _numberOfElements++;
    }
  }

  @override
  void merge(covariant BloomFilter<T> other) {
    // Validate that the filters are compatible
    assert(arraySize == other.arraySize, 'Cannot merge Bloom filters with different array sizes');
    assert(
      numberOfHashes == other.numberOfHashes,
      'Cannot merge Bloom filters with different number of hash functions',
    );
    assert(murmur == other.murmur, 'Cannot merge Bloom filters using different hash algorithms');
    assert(
      !murmur || hashSeed == other.hashSeed,
      'Cannot merge Bloom filters with different hash seeds',
    );

    // Merge the bit arrays using OR operation
    bitArray.or(other.bitArray);

    // Update element count (this is an approximation since there might be overlaps)
    _numberOfElements += other._numberOfElements;
  }

  /// returns false if the element is definitely not in among the added
  /// elements, returns true if it might be contained
  @override
  bool contains({required T item}) => bitArray[_getHash(item: item) % arraySize];

  /// resets all bits to false
  @override
  void clear() {
    bitArray.clearAll();
    _numberOfElements = 0;
  }

  /// [_getHash] supports two methods for creating hashes:
  /// 1. Dart's default - <object>.hashCode
  /// 2. MurmurHash - It uses a combination of <object>.toString()
  /// and <object>.hashCode to as an input to murmur hash algo
  int _getHash({required T item}) {
    if (murmur) {
      return MurmurHash.v3(item.toString() + item.hashCode.toString(), hashSeed);
    } else {
      return item.hashCode;
    }
  }
}
