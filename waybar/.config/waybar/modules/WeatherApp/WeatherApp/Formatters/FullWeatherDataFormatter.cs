namespace WeatherApp.Formatters;

using WeatherApp.Models;

public class FullWeatherDataFormatter : IWeatherDataFormatter
{
    public string FormatText(WeatherData data)
    {
        return FormatString(data);
    }

    public string FormatTooltip(WeatherData data)
    {
        return FormatString(data);
    }

    private string FormatString(WeatherData data)
    {
        return $"{data.Location}: {data.Temperature} ({data.Condition})";
    }
}
