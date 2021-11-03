class Weather {
  String cityName;
  String country;
  int id;
  int temperature;
  int humidity;
  String description;

  Weather(this.cityName, this.country, this.id, this.temperature, this.humidity, this.description);

  Weather.fromJson(Map<String, dynamic> json)
    : cityName = json['name'],
      country = json['sys']['country'],
      id = json['weather'][0]['id'],
      temperature = (json['main']['temp'] - 273.15).toInt(),
      humidity = json['main']['humidity'],
      description = json['weather'][0]['description'];
}

// https://flutter.dev/docs/development/data-and-backend/json
