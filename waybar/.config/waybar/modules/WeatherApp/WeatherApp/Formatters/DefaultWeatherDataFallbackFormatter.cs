namespace WeatherApp.Formatters;

public class DefaultWeatherDataFallbackFormatter : IWeatherDataFallbackFormatter
{
    public string FormatText(string location)
    {
        return "N/A";
    }

    public string FormatTooltip(string location)
    {
        return "N/A";
    }
}
