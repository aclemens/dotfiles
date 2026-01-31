using System.Text.Json;
using WeatherApp.Models;
using WeatherApp.Output;
using WeatherApp.Services;

namespace WeatherApp;

public class WeatherApplication
{
    private readonly IWeatherService _weatherService;
    private readonly WeatherSettings _settings;
    private readonly IWeatherOutputBuilder _outputBuilder;

    public WeatherApplication(
        IWeatherService weatherService,
        WeatherSettings settings,
        IWeatherOutputBuilder outputBuilder
    )
    {
        _weatherService = weatherService;
        _settings = settings;
        _outputBuilder = outputBuilder;
    }

    public async Task<string> RunAsync()
    {
        var locations = BuildLocations();
        var weatherByLocation = await FetchWeatherAsync(locations);
        var output = _outputBuilder.Build(_settings, weatherByLocation);

        return JsonSerializer.Serialize(
            new { output.Text, output.Tooltip },
            new JsonSerializerOptions { WriteIndented = false }
        );
    }

    private HashSet<string> BuildLocations()
    {
        return new HashSet<string>(_settings.TooltipLocations)
        {
            _settings.TextLocation
        };
    }

    private async Task<IReadOnlyDictionary<string, WeatherData?>> FetchWeatherAsync(
        IEnumerable<string> locations
    )
    {
        var weatherTasks = locations.ToDictionary(
            location => location,
            _weatherService.GetWeatherAsync
        );

        await Task.WhenAll(weatherTasks.Values);

        return weatherTasks.ToDictionary(
            entry => entry.Key,
            entry => entry.Value.Result
        );
    }
}
