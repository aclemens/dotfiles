namespace WeatherApp.Services;

using WeatherApp.Models;

public interface IWeatherService
{
    /// <summary>
    /// Fetches weather data for the specified locations from the wttr.in API.
    /// </summary>
    /// <param name="location">the location to look the weather up for.</param>
    /// <returns>A WeatherData object containing the weather information, or null when unavailable.</returns>
    Task<WeatherData?> GetWeatherAsync(string location);
}
