import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/app/app.dart';
import 'package:student_flow/app/providers.dart';
import 'package:student_flow/data/local/app_database.dart';

void main() {
  late StudentFlowDatabase database;

  setUp(() {
    database = StudentFlowDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  Widget testApp() => ProviderScope(
    overrides: [databaseProvider.overrideWith((ref) async => database)],
    child: const StudentFlowApp(),
  );

  testWidgets('home explains the safe-to-spend estimate', (tester) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Safe to spend until next payday'), findsOneWidget);
    expect(find.text(r'$1,124.63'), findsOneWidget);
    expect(find.textContaining('Estimate only'), findsOneWidget);
    expect(find.text('Demo data'), findsOneWidget);
  });

  testWidgets('transactions can be reached and filtered to pending', (
    tester,
  ) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Transactions'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Pending'));
    await tester.pumpAndSettle();

    expect(find.text('1 transaction'), findsOneWidget);
    expect(find.text('Metro groceries'), findsOneWidget);
    expect(find.text('September rent'), findsNothing);
  });

  testWidgets('home tolerates 200 percent system text scaling', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    expect(find.text('Safe to spend until next payday'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('income estimates respond to changing expected hours', (
    tester,
  ) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Income'));
    await tester.pumpAndSettle();

    expect(find.text('Possible paycheques'), findsOneWidget);
    expect(
      find.textContaining('Next payday estimate: 18 Sep 2026'),
      findsOneWidget,
    );
    expect(find.text('Conservative'), findsOneWidget);
    expect(find.text('Expected'), findsOneWidget);
    expect(find.text('Optimistic'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(1), '10');
    await tester.tap(find.text('Update estimates'));
    await tester.pumpAndSettle();

    expect(find.text(r'$149.24'), findsOneWidget);
    expect(find.text('Income estimates updated.'), findsOneWidget);
  });

  testWidgets('budget switches between monthly and payday views', (
    tester,
  ) async {
    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Budget'));
    await tester.pumpAndSettle();

    expect(find.text('Category plan'), findsOneWidget);
    expect(find.text('Recurring bills detected'), findsOneWidget);
    expect(find.text('Forecasted balance timeline'), findsOneWidget);

    await tester.tap(find.text('Until payday'));
    await tester.pumpAndSettle();

    expect(find.text('12 Sep 2026–18 Sep 2026'), findsOneWidget);
    expect(find.textContaining('Lowest forecast balance:'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('income and budget tolerate 200 percent text scaling', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Income'));
    await tester.pumpAndSettle();
    expect(find.text('Work assumptions'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Budget'));
    await tester.pumpAndSettle();
    expect(find.text('Category plan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
