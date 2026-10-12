import 'package:flutter_test/flutter_test.dart';
import 'package:lab3_flutter_details/main.dart';

void main() {
  testWidgets('Открывается каталог занятий', (tester) async {
    await tester.pumpWidget(const DetailsLabApp());
    expect(find.text('Flutter с нуля'), findsOneWidget);
  });
}
