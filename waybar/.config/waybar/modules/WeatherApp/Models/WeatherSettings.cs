namespace WeatherApp.Models;

public class WeatherSettings
{
    public string TextLocation { get; set; } = "Bensheim";
    public string TextFormat { get; set; } = "%t+%C";
    public List<string> TooltipLocations { get; set; } = new();
    public string TooltipFormat { get; set; } = "%l:%c%t+(%C)\\n";
}