using Moq;
using Moq.Protected;
using System.Net;
using System.Text;
using WeatherApp.Services;

namespace WeatherApp.Tests.Services;

public class WttrInWeatherServiceTests
{
    private readonly Mock<HttpMessageHandler> _mockHttpMessageHandler;
    private readonly HttpClient _httpClient;
    private readonly WttrInWeatherService _sut;

    public WttrInWeatherServiceTests()
    {
        _mockHttpMessageHandler = new Mock<HttpMessageHandler>();
        _httpClient = new HttpClient(_mockHttpMessageHandler.Object)
        {
            BaseAddress = new Uri("http://localhost")
        };
        _sut = new WttrInWeatherService(_httpClient);
    }

    [Fact]
    public async Task GetWeatherAsync_Location_ReturnsWeatherData()
    {
        // Arrange
        var response = "+20°C|Clear";
        var location = "Bensheim";
        SetupHttpResponse(response);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.NotNull(result);
        Assert.Equal("Bensheim", result.Location);
        Assert.Equal("+20°C", result.Temperature);
        Assert.Equal("Clear", result.Condition);

        _mockHttpMessageHandler.Protected().Verify(
            "SendAsync",
            Times.Once(),
            ItExpr.IsAny<HttpRequestMessage>(),
            ItExpr.IsAny<CancellationToken>()
        );
    }

    [Fact]
    public async Task GetWeatherAsync_EmptyResponse_ReturnsNull()
    {
        // Arrange
        var location = "Bensheim";
        SetupHttpResponse(string.Empty);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task GetWeatherAsync_HttpRequestThrowsException_ReturnsNull()
    {
        // Arrange
        var location = "Bensheim";

        _mockHttpMessageHandler.Protected()
            .Setup<Task<HttpResponseMessage>>(
                "SendAsync",
                ItExpr.IsAny<HttpRequestMessage>(),
                ItExpr.IsAny<CancellationToken>()
            )
            .ThrowsAsync(new HttpRequestException("Network error"));

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Null(result);
    }

    private void SetupHttpResponse(string responseContent)
    {
        var response = new HttpResponseMessage(HttpStatusCode.OK)
        {
            Content = new StringContent(responseContent, Encoding.UTF8, "text/plain")
        };

        _mockHttpMessageHandler.Protected()
            .Setup<Task<HttpResponseMessage>>(
                "SendAsync",
                ItExpr.IsAny<HttpRequestMessage>(),
                ItExpr.IsAny<CancellationToken>()
            )
            .ReturnsAsync(response);
    }
}
