namespace WeatherApp.Services;

using WeatherApp.Models;

public interface IWeatherService
{
    /// <summary>
    /// Retrieves weather data for the specified locations.
    /// </summary>
    /// <param name="locations">A collection of location names.</param>
    /// <returns>A WeatherData object containing the weather information.</returns>
    Task<WeatherData> GetWeatherAsync(IEnumerable<string> locations);
}
