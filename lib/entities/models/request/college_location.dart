class CollegeLocation {
    double latitude;
    double longitude;

    CollegeLocation({required this.latitude, required this.longitude});

    factory CollegeLocation.fromJson(Map<String, dynamic> json) {
        return CollegeLocation(
            latitude: double.parse(json['latitude']),
            longitude: double.parse(json['longitude']),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['latitude'] = this.latitude;
        data['longitude'] = this.longitude;
        return data;
    }
}