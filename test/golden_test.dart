import 'package:flutter/material.dart';
import 'package:flutter_html_3_19_deprecations/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data.dart';

class TestApp extends StatelessWidget {
  final Widget body;

  TestApp(this.body);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }
}

void testHtml(String name, String htmlData) {
  testWidgets('$name golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        Html(
          data: htmlData,
        ),
      ),
    );
    expect(find.byType(Html), findsOneWidget);
//    await expectLater(find.byType(Html), matchesGoldenFile('./goldens/$name.png'));
  });
}

void main() {
  //Test each HTML element
  testData.forEach((key, value) {
    testHtml(key, value);
  });

  //Test whitespace processing:
  testWidgets('whitespace golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        Html(data: """
          <p id='whitespace'>
      These two lines should have an identical length:<br /><br />

            The     quick   <b> brown </b><u><i> fox </i></u> jumped over   the
             lazy




             dog.<br />
            The quick brown fox jumped over the lazy dog.
      </p>
          """),
      ),
    );
    //    await expectLater(find.byType(Html), matchesGoldenFile('./goldens/whitespace.png'));
  });

  testWidgets('whitespace between inline elements golden test', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        Html(
          data:"""<b>Harry</b> <b>Potter</b>""",
        ),
      ),
    );
    // await expectLater(find.byType(Html), matchesGoldenFile('./goldens/whitespace_btwn_inline.png'));
  });
}
