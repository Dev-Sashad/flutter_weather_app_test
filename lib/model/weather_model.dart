class WeatherData {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Hourly> hourly;
  List<Daily> daily;

  WeatherData(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.hourly,
      this.daily});

  WeatherData.fromJson(Map<String, dynamic> json) {
    if (json["lat"] is double) this.lat = json["lat"];
    if (json["lon"] is double) this.lon = json["lon"];
    if (json["timezone"] is String) this.timezone = json["timezone"];
    if (json["timezone_offset"] is int)
      this.timezoneOffset = json["timezone_offset"];
    if (json["current"] is Map)
      this.current =
          json["current"] == null ? null : Current.fromJson(json["current"]);
    if (json["hourly"] is List)
      this.hourly = json["hourly"] == null
          ? null
          : (json["hourly"] as List).map((e) => Hourly.fromJson(e)).toList();
    if (json["daily"] is List)
      this.daily = json["daily"] == null
          ? null
          : (json["daily"] as List).map((e) => Daily.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["lat"] = this.lat;
    data["lon"] = this.lon;
    data["timezone"] = this.timezone;
    data["timezone_offset"] = this.timezoneOffset;
    if (this.current != null) data["current"] = this.current.toJson();
    if (this.hourly != null)
      data["hourly"] = this.hourly.map((e) => e.toJson()).toList();
    if (this.daily != null)
      data["daily"] = this.daily.map((e) => e.toJson()).toList();
    return data;
  }
}

class Daily {
  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  double moonPhase;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather2> weather;
  int clouds;
  double pop;
  double uvi;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi});

  Daily.fromJson(Map<String, dynamic> json) {
    if (json["dt"] is int) this.dt = json["dt"];
    if (json["sunrise"] is int) this.sunrise = json["sunrise"];
    if (json["sunset"] is int) this.sunset = json["sunset"];
    if (json["moonrise"] is int) this.moonrise = json["moonrise"];
    if (json["moonset"] is int) this.moonset = json["moonset"];
    if (json["moon_phase"] is double) this.moonPhase = json["moon_phase"];
    if (json["temp"] is Map)
      this.temp = json["temp"] == null ? null : Temp.fromJson(json["temp"]);
    if (json["feels_like"] is Map)
      this.feelsLike = json["feels_like"] == null
          ? null
          : FeelsLike.fromJson(json["feels_like"]);
    if (json["pressure"] is int) this.pressure = json["pressure"];
    if (json["humidity"] is int) this.humidity = json["humidity"];
    if (json["dew_point"] is double) this.dewPoint = json["dew_point"];
    if (json["wind_speed"] is double) this.windSpeed = json["wind_speed"];
    if (json["wind_deg"] is int) this.windDeg = json["wind_deg"];
    if (json["wind_gust"] is double) this.windGust = json["wind_gust"];
    if (json["weather"] is List)
      this.weather = json["weather"] == null
          ? null
          : (json["weather"] as List).map((e) => Weather2.fromJson(e)).toList();
    if (json["clouds"] is int) this.clouds = json["clouds"];
    if (json["pop"] is double) this.pop = json["pop"];
    if (json["uvi"] is double) this.uvi = json["uvi"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dt"] = this.dt;
    data["sunrise"] = this.sunrise;
    data["sunset"] = this.sunset;
    data["moonrise"] = this.moonrise;
    data["moonset"] = this.moonset;
    data["moon_phase"] = this.moonPhase;
    if (this.temp != null) data["temp"] = this.temp.toJson();
    if (this.feelsLike != null) data["feels_like"] = this.feelsLike.toJson();
    data["pressure"] = this.pressure;
    data["humidity"] = this.humidity;
    data["dew_point"] = this.dewPoint;
    data["wind_speed"] = this.windSpeed;
    data["wind_deg"] = this.windDeg;
    data["wind_gust"] = this.windGust;
    if (this.weather != null)
      data["weather"] = this.weather.map((e) => e.toJson()).toList();
    data["clouds"] = this.clouds;
    data["pop"] = this.pop;
    data["uvi"] = this.uvi;
    return data;
  }
}

class Weather2 {
  int id;
  String main;
  String description;
  String icon;

  Weather2({this.id, this.main, this.description, this.icon});

  Weather2.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["main"] is String) this.main = json["main"];
    if (json["description"] is String) this.description = json["description"];
    if (json["icon"] is String) this.icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["main"] = this.main;
    data["description"] = this.description;
    data["icon"] = this.icon;
    return data;
  }
}

class FeelsLike {
  double day;
  double night;
  double eve;
  double morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    if (json["day"] is double) this.day = json["day"];
    if (json["night"] is double) this.night = json["night"];
    if (json["eve"] is double) this.eve = json["eve"];
    if (json["morn"] is double) this.morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["day"] = this.day;
    data["night"] = this.night;
    data["eve"] = this.eve;
    data["morn"] = this.morn;
    return data;
  }
}

class Temp {
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    if (json["day"] is double) this.day = json["day"];
    if (json["min"] is double) this.min = json["min"];
    if (json["max"] is double) this.max = json["max"];
    if (json["night"] is double) this.night = json["night"];
    if (json["eve"] is double) this.eve = json["eve"];
    if (json["morn"] is double) this.morn = json["morn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["day"] = this.day;
    data["min"] = this.min;
    data["max"] = this.max;
    data["night"] = this.night;
    data["eve"] = this.eve;
    data["morn"] = this.morn;
    return data;
  }
}

class Hourly {
  int dt;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  int uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather1> weather;
  int pop;

  Hourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.pop});

  Hourly.fromJson(Map<String, dynamic> json) {
    if (json["dt"] is int) this.dt = json["dt"];
    if (json["temp"] is double) this.temp = json["temp"];
    if (json["feels_like"] is double) this.feelsLike = json["feels_like"];
    if (json["pressure"] is int) this.pressure = json["pressure"];
    if (json["humidity"] is int) this.humidity = json["humidity"];
    if (json["dew_point"] is double) this.dewPoint = json["dew_point"];
    if (json["uvi"] is int) this.uvi = json["uvi"];
    if (json["clouds"] is int) this.clouds = json["clouds"];
    if (json["visibility"] is int) this.visibility = json["visibility"];
    if (json["wind_speed"] is double) this.windSpeed = json["wind_speed"];
    if (json["wind_deg"] is int) this.windDeg = json["wind_deg"];
    if (json["wind_gust"] is double) this.windGust = json["wind_gust"];
    if (json["weather"] is List)
      this.weather = json["weather"] == null
          ? null
          : (json["weather"] as List).map((e) => Weather1.fromJson(e)).toList();
    if (json["pop"] is int) this.pop = json["pop"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dt"] = this.dt;
    data["temp"] = this.temp;
    data["feels_like"] = this.feelsLike;
    data["pressure"] = this.pressure;
    data["humidity"] = this.humidity;
    data["dew_point"] = this.dewPoint;
    data["uvi"] = this.uvi;
    data["clouds"] = this.clouds;
    data["visibility"] = this.visibility;
    data["wind_speed"] = this.windSpeed;
    data["wind_deg"] = this.windDeg;
    data["wind_gust"] = this.windGust;
    if (this.weather != null)
      data["weather"] = this.weather.map((e) => e.toJson()).toList();
    data["pop"] = this.pop;
    return data;
  }
}

class Weather1 {
  int id;
  String main;
  String description;
  String icon;

  Weather1({this.id, this.main, this.description, this.icon});

  Weather1.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["main"] is String) this.main = json["main"];
    if (json["description"] is String) this.description = json["description"];
    if (json["icon"] is String) this.icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["main"] = this.main;
    data["description"] = this.description;
    data["icon"] = this.icon;
    return data;
  }
}

class Current {
  int dt;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  int uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  List<Weather> weather;

  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.weather});

  Current.fromJson(Map<String, dynamic> json) {
    if (json["dt"] is int) this.dt = json["dt"];
    if (json["sunrise"] is int) this.sunrise = json["sunrise"];
    if (json["sunset"] is int) this.sunset = json["sunset"];
    if (json["temp"] is double) this.temp = json["temp"];
    if (json["feels_like"] is double) this.feelsLike = json["feels_like"];
    if (json["pressure"] is int) this.pressure = json["pressure"];
    if (json["humidity"] is int) this.humidity = json["humidity"];
    if (json["dew_point"] is double) this.dewPoint = json["dew_point"];
    if (json["uvi"] is int) this.uvi = json["uvi"];
    if (json["clouds"] is int) this.clouds = json["clouds"];
    if (json["visibility"] is int) this.visibility = json["visibility"];
    if (json["wind_speed"] is double) this.windSpeed = json["wind_speed"];
    if (json["wind_deg"] is int) this.windDeg = json["wind_deg"];
    if (json["weather"] is List)
      this.weather = json["weather"] == null
          ? null
          : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dt"] = this.dt;
    data["sunrise"] = this.sunrise;
    data["sunset"] = this.sunset;
    data["temp"] = this.temp;
    data["feels_like"] = this.feelsLike;
    data["pressure"] = this.pressure;
    data["humidity"] = this.humidity;
    data["dew_point"] = this.dewPoint;
    data["uvi"] = this.uvi;
    data["clouds"] = this.clouds;
    data["visibility"] = this.visibility;
    data["wind_speed"] = this.windSpeed;
    data["wind_deg"] = this.windDeg;
    if (this.weather != null)
      data["weather"] = this.weather.map((e) => e.toJson()).toList();
    return data;
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["main"] is String) this.main = json["main"];
    if (json["description"] is String) this.description = json["description"];
    if (json["icon"] is String) this.icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["main"] = this.main;
    data["description"] = this.description;
    data["icon"] = this.icon;
    return data;
  }
}

class WeatherByTime {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Hourly> hourly;

  WeatherByTime(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.hourly});

  WeatherByTime.fromJson(Map<String, dynamic> json) {
    if (json["lat"] is double) this.lat = json["lat"];
    if (json["lon"] is double) this.lon = json["lon"];
    if (json["timezone"] is String) this.timezone = json["timezone"];
    if (json["timezone_offset"] is int)
      this.timezoneOffset = json["timezone_offset"];
    if (json["current"] is Map)
      this.current =
          json["current"] == null ? null : Current.fromJson(json["current"]);
    if (json["hourly"] is List)
      this.hourly = json["hourly"] == null
          ? null
          : (json["hourly"] as List).map((e) => Hourly.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["lat"] = this.lat;
    data["lon"] = this.lon;
    data["timezone"] = this.timezone;
    data["timezone_offset"] = this.timezoneOffset;
    if (this.current != null) data["current"] = this.current.toJson();
    if (this.hourly != null)
      data["hourly"] = this.hourly.map((e) => e.toJson()).toList();
    return data;
  }
}
