class AppDefaultConfig{

  static const String APP_NAME = "Flutter Demo";
  static List<int> getAvailableYears() {
    // return [2022,2021,2020,2019,2018];
    return [2022,2021,2020,2019];
  }
  static int getDefaultYear() {
    return getAvailableYears().first;
  }
  static int getAllowedRange() {
    return 2;
  }
  static List<String> getDefaultBranches() {
    return ["CS"];
  }
  static List<String> getDefaultDistricts() {
    return ["Chennai"];
  }
}