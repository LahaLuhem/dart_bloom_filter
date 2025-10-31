// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloom_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloomFilter<T> _$BloomFilterFromJson<T>(Map<String, dynamic> json) =>
    BloomFilter<T>(
        (json['expectedNumberOfElements'] as num).toInt(),
        (json['falsePositiveProbability'] as num).toDouble(),
        hashSeed: (json['hashSeed'] as num?)?.toInt() ?? 0,
        murmur: json['murmur'] as bool? ?? false,
      )
      ..bitArray = const BitArraySerializer().fromJson(json['bitArray'] as String)
      ..arraySize = (json['arraySize'] as num).toInt();

Map<String, dynamic> _$BloomFilterToJson<T>(BloomFilter<T> instance) => <String, dynamic>{
  'bitArray': const BitArraySerializer().toJson(instance.bitArray),
  'arraySize': instance.arraySize,
  'hashSeed': instance.hashSeed,
  'murmur': instance.murmur,
  'expectedNumberOfElements': instance.expectedNumberOfElements,
  'falsePositiveProbability': instance.falsePositiveProbability,
};
