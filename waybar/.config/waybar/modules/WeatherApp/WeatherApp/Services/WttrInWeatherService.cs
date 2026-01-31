using System.Text.Json;
using System.Text.Json.Nodes;
using WeatherApp.Models;

namespace WeatherApp.Services;

public class WttrInWeatherService : IWeatherService
{
    private readonly HttpClient _httpClient;

    public WttrInWeatherService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    /// <summary>
    /// Fetches weather data for the specified locations from the wttr.in API.
    /// </summary>
    /// <param name="location">the location to look the weather up for.</param>
    /// <returns>A WeatherData object containing the weather information, or null when unavailable.</returns>
    public async Task<WeatherData?> GetWeatherAsync(string location)
    {
        try
        {
            var url = $"{location}?format=%c%t|%C";
            var response = await _httpClient.GetStringAsync(url);

            if (string.IsNullOrWhiteSpace(response))
            {
                return null;
            }

            var parts = response.Split('|', 2);
            if (parts.Length != 2)
            {
                return null;
            }

            var weatherData = new WeatherData
            {
                Location = location,
                Temperature = parts[0],
                Condition = parts[1],
            };

            return weatherData;
        }
        catch (HttpRequestException)
        {
            return null;
        }
        catch (Exception)
        {
            return null;
        }
    }
}
