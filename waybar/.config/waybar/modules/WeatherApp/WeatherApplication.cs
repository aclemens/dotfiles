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
        var text = await _weatherService.GetWeatherAsync(new[] { _settings.TextLocation }, _settings.TextFormat);
        var tooltip = await _weatherService.GetWeatherAsync(_settings.TooltipLocations, _settings.TooltipFormat);

        var result = new WeatherResult
        {
            Text = text,
            Tooltip = tooltip
        };

        return JsonSerializer.Serialize(result, new JsonSerializerOptions
        {
            WriteIndented = false
        });
    }
}