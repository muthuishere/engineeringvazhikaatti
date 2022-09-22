
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared/TestDataGenerator.dart';
void main() {
  test('getCutoffForYearAndCommunity should return cutoff based on community and year', () {
    var branchWithCutoff = TestDataGenerator.getCSInAnnaUniversity();
    double cutOff= branchWithCutoff.getCutoffForYearAndCommunity( 2021, CommunityGroup.BC);
    expect(cutOff, 198.12);
    cutOff= branchWithCutoff.getCutoffForYearAndCommunity( 2020, CommunityGroup.MBC);
    expect(cutOff, 195.0);
  });
  test('cutOffsForCommunity should return cutoff corresponding to community as mentioned in data ', () {
    var branchWithCutoff = TestDataGenerator.getCSInAnnaUniversity();
    Map<int,double> cutOffs= branchWithCutoff.cutOffsForCommunity(CommunityGroup.BC);
    Map<int,double> expectedCutOffs = {2021:198.12,2020:197.0,2019:196.5,2018:199.25,2017:199.5};
    expect(cutOffs, expectedCutOffs);
  });
}