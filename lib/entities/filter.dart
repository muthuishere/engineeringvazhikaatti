class Filter{

   List<String> branchCodes=[];
   List<String> districts=[];


   int? distanceInKms=0;

   void setBranchCodes(List<String> branches){
    this.branchCodes=branches;
  }

   void setDistricts(List<String> districts){
    this.districts=districts;
  }


}