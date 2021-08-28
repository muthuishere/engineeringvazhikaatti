import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:test/test.dart';

void main() {
  test('Json Encode Settings', () {
    var settings = Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);

    String contents = jsonEncode(settings);

    expect(contents.length > 0, true);
    var newSettings = Settings.fromJson(jsonDecode(contents));
    expect(newSettings.communityGroup, settings.communityGroup);
    expect(newSettings.physics, settings.physics);
    expect(newSettings.chemistry, settings.chemistry);
    expect(newSettings.maths, settings.maths);
  });
}
