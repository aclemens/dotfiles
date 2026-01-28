namespace WeatherApp.Models;

public class WeatherSettings
{
    public string TextLocation { get; set; } = "Bensheim";
    public List<string> TooltipLocations { get; set; } = new();
}
