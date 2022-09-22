class Branch {
    String code;
    int count;
    String name;

    Branch({required this.code,required this.count, required this.name});

    factory Branch.fromJson(Map<String, dynamic> json) {
        return Branch(
            code: json['code'], 
            count: json['count'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['count'] = this.count;
        data['name'] = this.name;
        return data;
    }
}