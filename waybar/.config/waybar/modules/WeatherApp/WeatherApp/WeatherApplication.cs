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
        var text = await _weatherService.GetWeatherAsync(
            new[] { _settings.TextLocation },
            _settings.TextFormat
        );

        // Tooltip: jede Location separat anfragen wie wttr.in es erwartet
        var tooltipTasks = _settings.TooltipLocations.Select(location =>
            _weatherService.GetWeatherAsync(new[] { location }, "%l:%c%t+(%C)")
        );
        var tooltipResults = await Task.WhenAll(tooltipTasks);
        var tooltip = string.Join("\n", tooltipResults);

        var result = new WeatherResult { text = text, tooltip = tooltip };

        return JsonSerializer.Serialize(
            result,
            new JsonSerializerOptions { WriteIndented = false }
        );
    }
}
