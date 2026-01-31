using System.Text.Json;
using System.Text.Json.Nodes;
using WeatherApp.Models;

namespace WeatherApp.Services;

public class TextWttrInWeatherService : IWeatherService
{
    private readonly HttpClient _httpClient;

    public TextWttrInWeatherService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    /// <summary>
    /// Fetches weather data for the specified locations from the wttr.in API.
    /// </summary>
    /// <param name="location">the location to look the weather up for.</param>
    /// <returns>A WeatherData object containing the weather information.</returns>
    public async Task<WeatherData> GetWeatherAsync(string location)
    {
        try
        {
            var url = $"{location}?format=%c%t|%C";
            var response = await _httpClient.GetStringAsync(url);

            if (string.IsNullOrWhiteSpace(response))
            {
                throw new InvalidOperationException("Empty response from weather API");
            }

            var parts = response.Split('|', 2);
            if (parts.Length != 2)
            {
                throw new InvalidOperationException("Unexpected response format");
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
            return CreateErrorWeatherData("Network Error");
        }
        catch (InvalidOperationException)
        {
            return CreateErrorWeatherData("Invalid Data");
        }
        catch (Exception)
        {
            return CreateErrorWeatherData("Unexpected Error");
        }
    }

    private WeatherData CreateErrorWeatherData(string errorType)
    {
        return new WeatherData
        {
            Location = errorType,
            Temperature = "N/A",
            Condition = "Failed to fetch weather"
        };
    }
}
