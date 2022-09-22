import 'package:engineeringvazhikaatti/shared/copyable.dart';
import 'package:engineeringvazhikaatti/stores/AppDefaultConfig.dart';

class SearchFilter implements Copyable<SearchFilter>{

   List<String> branchCodes=AppDefaultConfig.getDefaultBranches();
   List<String> districts=AppDefaultConfig.getDefaultDistricts();
   String message ="";
   int distanceInKms=0;
   int year=AppDefaultConfig.getDefaultYear();
   bool searchByDistricts=true;



   @override
   SearchFilter copy() {
     var searchFilter = SearchFilter();
     searchFilter.branchCodes= branchCodes;
     searchFilter.districts= districts;
     searchFilter.message= message;
     searchFilter.distanceInKms= distanceInKms;
     searchFilter.year= year;
     searchFilter.searchByDistricts= searchByDistricts;
     return searchFilter;
   }

   @override
   SearchFilter copyWith({
     List<String>? branchCodes,
     List<String>? districts,
     String? message,
     int? distanceInKms,
     int? year,
     bool? searchByDistricts
   }) {

     var searchFilter = SearchFilter();
     searchFilter.branchCodes= branchCodes ?? this.branchCodes;
     searchFilter.districts= districts ?? this.districts;
     searchFilter.message= message?? this.message;
     searchFilter.distanceInKms= distanceInKms?? this.distanceInKms;
     searchFilter.year= year?? this.year;
     searchFilter.searchByDistricts= searchByDistricts?? this.searchByDistricts;
     return searchFilter;

   }




   void setBranchCodes(List<String> branches){
     this.branchCodes=branches;
   }

   void setDistricts(List<String>? districts){
     if(null != districts){
       this.districts=districts;
     }else{
     this.districts=[];
     }
   }
   void setDistanceInKms(int input){
     this.distanceInKms=input;
   }

   bool hasDistricts() {

     return searchByDistricts  && null!= this.districts && this.districts.length>0;
   }

   bool hasDistanceSet() {

     return searchByDistricts == false &&  null!= this.distanceInKms;
   }

   @override
   String toString() {
     return toJson().toString();
   }

   Map<String, dynamic> toJson() {

     //     List<String>? branchCodes,
     //      List<String>? districts,
     //      String? message,
     //      int? distanceInKms,
     //      int? year,
     //      bool? searchByDistricts

     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['message'] = this.message;
     data['distanceInKms'] = this.distanceInKms;
     data['year'] = this.year;
     data['searchByDistricts'] = this.searchByDistricts;
     if (branchCodes != null) {
       data['branchCodes'] = this.branchCodes.map((e) => "${e}").join(",");
     }
     if (this.districts != null) {
       data['districts'] = this.districts.map((e) => "${e}").join(",");
     }
     return data;
   }

  String getMessage() {

    message = "Searching on " +
        branchCodes.length.toString() + "branches";

      if(searchByDistricts){

        if(districts.length>0){
          message = message + " on " + districts.length.toString() + " districts";
        }else{
          message = message + " on " + " all districts";
        }

      }else{
        if(distanceInKms>0){
          message = message + " within " + distanceInKms.toString() + " kms";
        }else{
          message = message + " across tamilnadu " ;
        }
      }
      return message;
    }


}