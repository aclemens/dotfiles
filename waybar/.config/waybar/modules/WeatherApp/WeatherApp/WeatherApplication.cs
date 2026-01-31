using System.Text.Json;
using WeatherApp.Models;
using WeatherApp.Services;
using WeatherApp.Formatters;

namespace WeatherApp;

public class WeatherApplication
{
    private readonly IWeatherService _weatherService;
    private readonly WeatherSettings _settings;
    private readonly IWeatherDataFormatter _formatter;

    public WeatherApplication(IWeatherService weatherService, WeatherSettings settings, IWeatherDataFormatter formatter)
    {
        _weatherService = weatherService;
        _settings = settings;
        _formatter = formatter;
    }

    public async Task<string> RunAsync()
    {
        // merge weather locations for fetching
        var locations = new HashSet<string>(_settings.TooltipLocations)
        {
            _settings.TextLocation
        };

        var weatherTasks = locations.ToDictionary(
            location => location,
            _weatherService.GetWeatherAsync
        );

        await Task.WhenAll(weatherTasks.Values);

        var weatherByLocation = weatherTasks.ToDictionary(
            entry => entry.Key,
            entry => entry.Value.Result
        );

        // Format text from WeatherData
        var text = _formatter.FormatText(weatherByLocation[_settings.TextLocation]);
        var tooltip = string.Join(
            "\n",
            _settings.TooltipLocations.Select(
                location => _formatter.FormatTooltip(weatherByLocation[location])
            )
        );

        return JsonSerializer.Serialize(
            new { text, tooltip },
            new JsonSerializerOptions { WriteIndented = false }
        );
    }
}
