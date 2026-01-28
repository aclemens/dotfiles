using WeatherApp.Models;

namespace WeatherApp.Services;

public interface IWeatherService
{
    Task<WeatherData> GetWeatherAsync(IEnumerable<string> locations);
}
