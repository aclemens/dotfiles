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

        var textData = weatherByLocation[_settings.TextLocation];
        var text = textData is null
            ? "N/A"
            : _formatter.FormatText(textData);

        var tooltip = string.Join(
            "\n",
            _settings.TooltipLocations.Select(
                location =>
                {
                    var data = weatherByLocation[location];
                    return data is null
                        ? "N/A"
                        : _formatter.FormatTooltip(data);
                }
            )
        );

        return JsonSerializer.Serialize(
            new { text, tooltip },
            new JsonSerializerOptions { WriteIndented = false }
        );
    }
}
