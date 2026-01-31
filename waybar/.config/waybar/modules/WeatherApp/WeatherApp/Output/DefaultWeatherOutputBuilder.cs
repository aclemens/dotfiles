using WeatherApp.Formatters;
using WeatherApp.Models;

namespace WeatherApp.Output;

public class DefaultWeatherOutputBuilder : IWeatherOutputBuilder
{
    private readonly IWeatherDataFormatter _formatter;
    private readonly IWeatherDataFallbackFormatter _fallbackPolicy;

    public DefaultWeatherOutputBuilder(
        IWeatherDataFormatter formatter,
        IWeatherDataFallbackFormatter fallbackPolicy
    )
    {
        _formatter = formatter;
        _fallbackPolicy = fallbackPolicy;
    }

    public WeatherOutput Build(
        WeatherSettings settings,
        IReadOnlyDictionary<string, WeatherData?> weatherByLocation
    )
    {
        var textData = weatherByLocation[settings.TextLocation];
        var text = textData is null
            ? _fallbackPolicy.FormatText(settings.TextLocation)
            : _formatter.FormatText(textData);

        var tooltip = string.Join(
            "\n",
            settings.TooltipLocations.Select(
                location =>
                {
                    if (!weatherByLocation.TryGetValue(location, out var data) || data is null)
                    {
                        return _fallbackPolicy.FormatTooltip(location);
                    }

                    return _formatter.FormatTooltip(data);
                }
            )
        );

        return new WeatherOutput(text, tooltip);
    }
}
