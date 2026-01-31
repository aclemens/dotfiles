namespace WeatherApp.Formatters;

public interface IWeatherDataFallbackFormatter
{
    string FormatText(string location);
    string FormatTooltip(string location);
}
