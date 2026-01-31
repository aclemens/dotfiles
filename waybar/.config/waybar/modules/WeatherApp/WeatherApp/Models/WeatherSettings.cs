namespace WeatherApp.Models;

public class WeatherSettings
{
    public string TextLocation { get; set; } = string.Empty;
    public List<string> TooltipLocations { get; set; } = new();
}
