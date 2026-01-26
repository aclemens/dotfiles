using Microsoft.Extensions.DependencyInjection;
using Moq;
using Moq.Protected;
using System.Net;
using System.Net.Http;
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
    public async Task GetWeatherAsync_SingleLocation_ReturnsWeatherData()
    {
        // Arrange
        var expectedResponse = "20°C";
        var locations = new[] { "Bensheim" };

        SetupHttpResponse(expectedResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations);

        // Assert
        Assert.Equal(expectedResponse, result);

        _mockHttpMessageHandler.Protected().Verify(
            "SendAsync",
            Times.Once(),
            ItExpr.IsAny<HttpRequestMessage>(),
            ItExpr.IsAny<CancellationToken>()
        );
    }

    [Fact]
    public async Task GetWeatherAsync_MultipleLocations_ReturnsWeatherData()
    {
        // Arrange
        var expectedResponse = "15°C";
        var locations = new[] { "Bensheim", "Frankfurt", "Windesheim" };

        SetupHttpResponse(expectedResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations);

        // Assert
        Assert.Equal(expectedResponse, result);
    }

    [Fact]
    public async Task GetWeatherAsync_WithFormat_ReturnsFormattedWeatherData()
    {
        // Arrange
        var expectedResponse = "+20°C+☀️";
        var locations = new[] { "Bensheim" };
        var format = "%t+%C";

        SetupHttpResponse(expectedResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations, format);

        // Assert
        Assert.Equal(expectedResponse, result);
    }

    [Fact]
    public async Task GetWeatherAsync_WithNullFormat_ReturnsWeatherData()
    {
        // Arrange
        var expectedResponse = "Weather report";
        var locations = new[] { "Bensheim" };

        SetupHttpResponse(expectedResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations, null);

        // Assert
        Assert.Equal(expectedResponse, result);
    }

    [Fact]
    public async Task GetWeatherAsync_WithEmptyFormat_ReturnsWeatherData()
    {
        // Arrange
        var expectedResponse = "Weather report";
        var locations = new[] { "Bensheim" };

        SetupHttpResponse(expectedResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations, "");


        // Assert
        Assert.Equal(expectedResponse, result);
    }

    [Fact]
    public async Task GetWeatherAsync_EmptyLocations_ReturnsWeatherData()
    {
        // Arrange
        var expectedResponse = "Test";
        var locations = Array.Empty<string>();

        SetupHttpResponse(expectedResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations);

        // Assert
        Assert.Equal(expectedResponse, result);
    }

    [Fact]
    public async Task GetWeatherAsync_HttpRequestThrowsException_PropagatesException()
    {
        // Arrange
        var locations = new[] { "Bensheim" };

        _mockHttpMessageHandler.Protected()
            .Setup<Task<HttpResponseMessage>>(
                "SendAsync",
                ItExpr.IsAny<HttpRequestMessage>(),
                ItExpr.IsAny<CancellationToken>()
            )
            .ThrowsAsync(new HttpRequestException("Network error"));

        // Act & Assert
        await Assert.ThrowsAsync<HttpRequestException>(() =>
            _sut.GetWeatherAsync(locations));
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
