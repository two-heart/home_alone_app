import 'package:json_annotation/json_annotation.dart';
import 'package:home_alone/model/weather.dart';

part 'weather_forecast.g.dart';

@JsonSerializable(nullable: true)
class WeatherForecast {
  String cod;
  int message;
  int cnt;
  List<ForecastList> list;
  City city;

  WeatherForecast({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}

@JsonSerializable(nullable: true)
@JsonKey(name: "list")
class ForecastList {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  Sys sys;
  String dtTxt;
  Rain rain;

  ForecastList(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.sys,
      this.dtTxt,
      this.rain});

  factory ForecastList.fromJson(Map<String, dynamic> json) =>
      _$ForecastListFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListToJson(this);
}

@JsonSerializable(nullable: true)
class Main {
  double temp;
  @JsonKey(nullable: true)
  double feels_like;
  @JsonKey(nullable: true)
  double temp_min;
  @JsonKey(nullable: true)
  double temp_max;
  @JsonKey(nullable: true)
  int pressure;
  @JsonKey(nullable: true)
  int sea_level;
  @JsonKey(nullable: true)
  int grnd_level;
  @JsonKey(nullable: true)
  int humidity;
  @JsonKey(nullable: true)
  double temp_kf;

  Main(
      {this.temp,
      this.feels_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.sea_level,
      this.grnd_level,
      this.humidity,
      this.temp_kf});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable(nullable: true)
class Clouds {
  int all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable(nullable: true)
class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable(nullable: true)
class Sys {
  String pod;

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable(nullable: true)
class Rain {
  @JsonKey(nullable: true)
  double d3h;

  Rain({this.d3h});

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);

  Map<String, dynamic> toJson() => _$RainToJson(this);
}

@JsonSerializable(nullable: true)
class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable(nullable: true)
class Coord {
  double lat;
  double lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}
