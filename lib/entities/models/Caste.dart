enum CommunityGroup{
BC,BCM,MBC,OC,SC,SCA,ST
}
extension ParseToString on CommunityGroup {
  String toValidString() {
    return this.toString().split('.').last;
  }
}