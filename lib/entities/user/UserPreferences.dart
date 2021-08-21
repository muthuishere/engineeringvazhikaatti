class UserPreferences{

   List<String> branchCodes=List.empty();
   List<String> districts=List.empty();

   void setBranches(List<String> branches){
    this.branchCodes=branches;
  }

   void setDistricts(List<String> districts){
    this.districts=districts;
  }

}