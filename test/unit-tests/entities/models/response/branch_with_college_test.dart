

import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared/TestDataGenerator.dart';

void main() {
  test('can create branch detail from collegeDetail', () {

    // Get a college Detail Instance
    // Get a branch detail instance
    // Get a community group
    // Get a year
    var collegeDetailWithBranch = TestDataGenerator.getAnnaUniversityCollege();

    // get the first branch detail
    var branchDetail =TestDataGenerator.getCSInAnnaUniversity();

    CommunityGroup communityGroup = CommunityGroup.BC;

    var year = 2021;


    BranchWithCollege branchWithCollege = BranchWithCollege.fromCollegeDetailWithBranches(collegeDetailWithBranch,branchDetail,communityGroup,year);

    expect(branchWithCollege.code, branchDetail.code);
    expect(branchWithCollege.name, branchDetail.name);
    expect(branchWithCollege.collegeDetail.code, collegeDetailWithBranch.code);
    expect(branchWithCollege.collegeDetail.name, collegeDetailWithBranch.name);
    expect(branchWithCollege.collegeDetail.address, collegeDetailWithBranch.address);
    expect(branchWithCollege.cutoff, equals(198.12));
    //
    // var expectedCutoffs = {2021:198.12,2020:197,2019:196.12,2019:196.5,    2018:199.25,    2017:199.5};
    // expect(branchWithCollege.cutoffs, equals(expectedCutoffs));
    //now generate branch detail
  });
}