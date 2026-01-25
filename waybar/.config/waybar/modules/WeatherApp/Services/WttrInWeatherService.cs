namespace WeatherApp.Services;

public class WttrInWeatherService : IWeatherService
{
    private readonly HttpClient _httpClient;

    public WttrInWeatherService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<string> GetWeatherAsync(IEnumerable<string> locations, string? format = null)
    {
        var locationStr = string.Join(",", locations);
        var formatStr = string.IsNullOrEmpty(format) ? "" : $"?format={format}";
        var url = $"{{{locationStr}}}{formatStr}";

        var response = await _httpClient.GetStringAsync(url);
        return response.Trim();
    }
}
