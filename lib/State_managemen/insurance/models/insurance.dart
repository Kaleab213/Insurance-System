import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../insurance.dart';

@immutable
class Insurance extends Equatable {
  Insurance({
    // required this.id,
    required this.size,
    required this.location,
    required this.numberOfRooms,
    required this.propertyType,
    required this.coverageLevel,
  });
  // final int id;
  final String size;
  final String location;
  final int numberOfRooms;
  final String propertyType;
  final String coverageLevel;

  @override
  List<Object> get props =>
      [size, location, numberOfRooms, propertyType, coverageLevel];

  factory Insurance.fromJson(Map<String, dynamic> json) {
    return Insurance(
      // id: json['id'],
      size: json['size'],
      location: json['location'],
      numberOfRooms: json['numberOfRooms'],
      propertyType: json['propertyType'],
      coverageLevel: json['coverageLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'size': size,
      'location': location,
      'numberOfRooms': numberOfRooms,
      'propertyType': propertyType,
      'coverageLevel': coverageLevel,
    };
  }

  @override
  String toString() =>
      'Insurance { size: $size, location: $location, numberOfRooms: $numberOfRooms, propertyType: $propertyType, coverageLevel: $coverageLevel }';
}
