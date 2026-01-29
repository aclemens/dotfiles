namespace WeatherApp.Formatters;

using WeatherApp.Models;

public class ShortWeatherDataFormatter : IWeatherDataFormatter
{
    public string FormatText(WeatherData data)
    {
        return data.Temperature;
    }

    public string FormatTooltip(WeatherData data)
    {
        return $"{data.Location}: {data.Temperature} ({data.Condition})";
    }
}
