using WeatherApp.Models;

namespace WeatherApp.Output;

public interface IWeatherOutputBuilder
{
    WeatherOutput Build(WeatherSettings settings, IReadOnlyDictionary<string, WeatherData?> weatherByLocation);
}
