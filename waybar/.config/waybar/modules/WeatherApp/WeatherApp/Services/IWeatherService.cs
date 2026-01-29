using WeatherApp.Models;

namespace WeatherApp.Services;

public interface IWeatherService
{
    /// <summary>
    /// Retrieves weather data for the specified locations.
    /// </summary>
    /// <param name="locations">A collection of location names.</param>
    /// <returns>A task that represents the asynchronous operation. The task result contains the weather data.</returns>
    Task<WeatherData> GetWeatherAsync(IEnumerable<string> locations);
}
