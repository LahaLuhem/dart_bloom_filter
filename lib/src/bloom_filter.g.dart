// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloom_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloomFilter<T> _$BloomFilterFromJson<T>(Map<String, dynamic> json) =>
    BloomFilter<T>(
        (json['expectedNumberOfElements'] as num).toInt(),
        (json['falsePositiveProbability'] as num).toDouble(),
      )
      ..bitArray = const BitArraySerializer().fromJson(json['bitArray'] as String)
      ..arraySize = (json['arraySize'] as num).toInt()
      ..hashSeed = (json['hashSeed'] as num).toInt()
      ..murmur = json['murmur'] as bool
      ..numberOfElements = (json['numberOfElements'] as num).toInt()
      ..numberOfHashes = (json['numberOfHashes'] as num).toInt()
      ..konstant = (json['konstant'] as num).toDouble();

Map<String, dynamic> _$BloomFilterToJson<T>(BloomFilter<T> instance) => <String, dynamic>{
  'bitArray': const BitArraySerializer().toJson(instance.bitArray),
  'arraySize': instance.arraySize,
  'hashSeed': instance.hashSeed,
  'murmur': instance.murmur,
  'numberOfElements': instance.numberOfElements,
  'expectedNumberOfElements': instance.expectedNumberOfElements,
  'falsePositiveProbability': instance.falsePositiveProbability,
  'numberOfHashes': instance.numberOfHashes,
  'konstant': instance.konstant,
};
