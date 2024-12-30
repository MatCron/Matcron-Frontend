import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class AddMattressTypeFormRobot {
  final WidgetTester tester;

  AddMattressTypeFormRobot(this.tester);

  Future<void> findAllFields() async {
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(9));
    expect(find.text("+Add Mattress Type"), findsOneWidget);
  }

  Future<void> enterTypeName(String typeName) async {
    final typeNameField = find.widgetWithText(TextFormField, "Type Name");
    await tester.enterText(typeNameField, typeName);
  }

  Future<void> enterDimensions(String width, String length, String height) async {
    await tester.enterText(find.widgetWithText(TextFormField, "Width"), width);
    await tester.enterText(find.widgetWithText(TextFormField, "Length"), length);
    await tester.enterText(find.widgetWithText(TextFormField, "Height"), height);
  }

  Future<void> enterMaterialComposition(String material) async {
    final materialField = find.widgetWithText(TextFormField, "Material Composition");
    await tester.enterText(materialField, material);
  }

  Future<void> enterAllergenInfo(String info) async {
    final allergenField = find.widgetWithText(TextFormField, "Allergen Information");
    await tester.enterText(allergenField, info);
  }

  Future<void> selectLifeSpan(String lifeSpan) async {
    final lifeSpanDropdown = find.widgetWithText(DropdownButtonFormField, "Life Span");
    await tester.tap(lifeSpanDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text(lifeSpan).last);
    await tester.pumpAndSettle();
  }

  Future<void> enterManufacturer(String manufacturer) async {
    final manufacturerField = find.widgetWithText(TextFormField, "Manufacturer");
    await tester.enterText(manufacturerField, manufacturer);
  }

  Future<void> enterRecycleInfo(String recycleInfo) async {
    final recycleInfoField = find.widgetWithText(TextFormField, "Recycle Information");
    await tester.enterText(recycleInfoField, recycleInfo);
  }

  Future<void> enterRotationTimer(String timer) async {
    final timerField = find.widgetWithText(TextFormField, "Rotation Timer");
    await tester.enterText(timerField, timer);
  }

  Future<void> selectWashable(String washable) async {
    final washableDropdown = find.widgetWithText(DropdownButtonFormField, "washable");
    await tester.tap(washableDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text(washable).last);
    await tester.pumpAndSettle();
  }

  Future<void> submitForm() async {
    final submitButton = find.text("+Add Mattress Type");
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  }
}