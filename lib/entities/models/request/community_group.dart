enum CommunityGroup{
BC,BCM,MBC,MBCDNC,MBCV, OC,SC,SCA,ST
}
extension ParseToString on CommunityGroup {
  String value() {
    return this.toString().split('.').last.toLowerCase();
  }

  String label() {
    return this.toString().split('.').last;
  }
}

