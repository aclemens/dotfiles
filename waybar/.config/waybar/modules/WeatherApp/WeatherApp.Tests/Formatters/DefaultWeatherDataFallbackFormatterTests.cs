using Xunit;

namespace WeatherApp.Formatters;

public class DefaultWeatherDataFallbackFormatterTests
{
    [Fact]
    public void FormatText_ReturnsNA()
    {
        var formatter = new DefaultWeatherDataFallbackFormatter();

        var result = formatter.FormatText("Berlin");

        Assert.Equal("N/A", result);
    }

    [Fact]
    public void FormatTooltip_ReturnsNA()
    {
        var formatter = new DefaultWeatherDataFallbackFormatter();

        var result = formatter.FormatTooltip("Berlin");

        Assert.Equal("N/A", result);
    }

    [Theory]
    [InlineData("")]
    [InlineData("New York")]
    public void FormatText_ReturnsNA_ForAnyLocation(string location)
    {
        var formatter = new DefaultWeatherDataFallbackFormatter();

        var result = formatter.FormatText(location);

        Assert.Equal("N/A", result);
    }

    [Theory]
    [InlineData("")]
    [InlineData("Tokyo")]
    public void FormatTooltip_ReturnsNA_ForAnyLocation(string location)
    {
        var formatter = new DefaultWeatherDataFallbackFormatter();

        var result = formatter.FormatTooltip(location);

        Assert.Equal("N/A", result);
    }
}