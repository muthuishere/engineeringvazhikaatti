import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/cutoffstatus.dart';
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:test/test.dart';

import '../../shared/test_initializer.dart';

void main() {
  setUp(() => TestInitializer.initLogs());
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

  test("cutoff status for with difference 2 should return yellow",(){

    var settings = Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);

    expect(settings.getCutOffStatusWith(140.0), CutoffStatus.YELLOW);
    expect(settings.getCutOffStatusWith(142.0), CutoffStatus.YELLOW);
    expect(settings.getCutOffStatusWith(138.0), CutoffStatus.YELLOW);



  });
  test("cutoff status for with difference less than 3 should return red",(){

    var settings = Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);

    expect(settings.getCutOffStatusWith(143.0), CutoffStatus.RED);
    expect(settings.getCutOffStatusWith(155.0), CutoffStatus.RED);
    expect(settings.getCutOffStatusWith(180.0), CutoffStatus.RED);



  });
  test("cutoff status for with difference greater than 2 should return green",(){

    var settings = Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);

    expect(settings.getCutOffStatusWith(137.0), CutoffStatus.GREEN);
    expect(settings.getCutOffStatusWith(135.0), CutoffStatus.GREEN);
    expect(settings.getCutOffStatusWith(120.0), CutoffStatus.GREEN);



  });

}
