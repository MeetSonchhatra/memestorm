import 'package:flutter_test/flutter_test.dart';
import 'package:memestorm/services/apis.dart';

void main() {
  test('Test API', () async{
    final response = await API.getMemes();
    expect(response.success, true);
  });
}