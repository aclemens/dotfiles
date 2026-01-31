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
    /// <returns>A WeatherData object containing the weather information.</returns>
    public async Task<WeatherData> GetWeatherAsync(string location)
    {
        try
        {
            var url = $"{location}?format=j1";
            var response = await _httpClient.GetStringAsync(url);

            if (string.IsNullOrWhiteSpace(response))
                throw new InvalidOperationException("Empty response from weather API");

            var json = JsonNode.Parse(response);
            if (json == null)
                throw new JsonException("Failed to parse JSON response");

            if (!IsValidWttrInResponse(json))
                throw new InvalidOperationException("Invalid weather data structure");

            if (!TryExtractWeatherData(json, out var weatherData))
                throw new InvalidOperationException("Failed to extract weather data");

            return weatherData;
        }
        catch (HttpRequestException)
        {
            return CreateErrorWeatherData("Network Error");
        }
        catch (JsonException)
        {
            return CreateErrorWeatherData("Invalid JSON");
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

    private bool IsValidWttrInResponse(JsonNode? json)
    {
        if (json == null) return false;

        var hasCurrentCondition = json["current_condition"]?.AsArray().Count > 0;
        var hasNearestArea = json["nearest_area"]?.AsArray().Count > 0;

        return hasCurrentCondition && hasNearestArea;
    }

    private bool TryExtractWeatherData(JsonNode json, out WeatherData weatherData)
    {
        weatherData = new WeatherData();

        try
        {
            // Location extraction
            var locationNode = json["nearest_area"]?[0]?["areaName"]?[0]?["value"];
            if (locationNode == null)
                return false;

            var location = SafeGetString(locationNode, string.Empty);
            if (string.IsNullOrEmpty(location))
                return false;
            weatherData.Location = location;

            // Temperature extraction  
            var tempNode = json["current_condition"]?[0]?["temp_C"];
            if (tempNode?.GetValue<string>() is string temp)
                weatherData.Temperature = $"{temp}°C";
            else
                weatherData.Temperature = "N/A";

            // Condition extraction
            var conditionNode = json["current_condition"]?[0]?["weatherDesc"]?[0]?["value"];
            weatherData.Condition = conditionNode?.GetValue<string>() ?? "Unknown";

            return true;
        }
        catch
        {
            return false;
        }
    }

    private string SafeGetString(JsonNode? node, string fallback = "N/A")
    {
        return node?.GetValue<string>() ?? fallback;
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
