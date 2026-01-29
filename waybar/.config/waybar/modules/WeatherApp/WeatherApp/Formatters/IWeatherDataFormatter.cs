namespace WeatherApp.Formatters;

using WeatherApp.Models;

public interface IWeatherDataFormatter
{
    string FormatText(WeatherData data);
    string FormatTooltip(WeatherData data);
}
