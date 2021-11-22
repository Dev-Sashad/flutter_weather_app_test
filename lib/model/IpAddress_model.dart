class IpAddressModel {
  String status;
  String country;
  String countryCode;
  String region;
  String regionName;
  String city;
  String zip;
  double lat;
  double lon;
  String timezone;
  String isp;
  String org;
  String as;
  String query;

  IpAddressModel(
      {this.status,
      this.country,
      this.countryCode,
      this.region,
      this.regionName,
      this.city,
      this.zip,
      this.lat,
      this.lon,
      this.timezone,
      this.isp,
      this.org,
      this.as,
      this.query});

  IpAddressModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) this.status = json["status"];
    if (json["country"] is String) this.country = json["country"];
    if (json["countryCode"] is String) this.countryCode = json["countryCode"];
    if (json["region"] is String) this.region = json["region"];
    if (json["regionName"] is String) this.regionName = json["regionName"];
    if (json["city"] is String) this.city = json["city"];
    if (json["zip"] is String) this.zip = json["zip"];
    if (json["lat"] is double) this.lat = json["lat"];
    if (json["lon"] is double) this.lon = json["lon"];
    if (json["timezone"] is String) this.timezone = json["timezone"];
    if (json["isp"] is String) this.isp = json["isp"];
    if (json["org"] is String) this.org = json["org"];
    if (json["as"] is String) this.as = json["as"];
    if (json["query"] is String) this.query = json["query"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["country"] = this.country;
    data["countryCode"] = this.countryCode;
    data["region"] = this.region;
    data["regionName"] = this.regionName;
    data["city"] = this.city;
    data["zip"] = this.zip;
    data["lat"] = this.lat;
    data["lon"] = this.lon;
    data["timezone"] = this.timezone;
    data["isp"] = this.isp;
    data["org"] = this.org;
    data["as"] = this.as;
    data["query"] = this.query;
    return data;
  }
}
