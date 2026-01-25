namespace WeatherApp.Services;

public interface IWeatherService
{
    Task<string> GetWeatherAsync(IEnumerable<string> locations, string? format = null);
}