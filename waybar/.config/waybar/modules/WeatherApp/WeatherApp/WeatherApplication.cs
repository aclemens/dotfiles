using System.Text.Json;
using WeatherApp.Models;
using WeatherApp.Services;

namespace WeatherApp;

public class WeatherApplication
{
    private readonly IWeatherService _weatherService;
    private readonly WeatherSettings _settings;

    public WeatherApplication(IWeatherService weatherService, WeatherSettings settings)
    {
        _weatherService = weatherService;
        _settings = settings;
    }

    public async Task<string> RunAsync()
    {
        var weatherData = await _weatherService.GetWeatherAsync(
            new[] { _settings.TextLocation }
        );

        // Format text from WeatherData
        var text = FormatWeatherData(weatherData);

        // Tooltip: jede Location separat anfragen wie wttr.in es erwartet
        var tooltipTasks = _settings.TooltipLocations.Select(location =>
            _weatherService.GetWeatherAsync(new[] { location })
        );
        var tooltipResults = await Task.WhenAll(tooltipTasks);
        var tooltip = string.Join("\n", tooltipResults.Select(data => FormatWeatherData(data)));

        var result = new WeatherResult { text = text, tooltip = tooltip };

        return JsonSerializer.Serialize(
            result,
            new JsonSerializerOptions { WriteIndented = false }
        );
    }

    private string FormatWeatherData(WeatherData data)
    {
        return $"{data.Location}: {data.Temperature} ({data.Condition})";
    }
}
