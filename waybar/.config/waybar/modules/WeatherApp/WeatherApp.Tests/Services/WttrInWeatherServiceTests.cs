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
    private readonly TextWttrInWeatherService _sut;

    public WttrInWeatherServiceTests()
    {
        _mockHttpMessageHandler = new Mock<HttpMessageHandler>();
        _httpClient = new HttpClient(_mockHttpMessageHandler.Object)
        {
            BaseAddress = new Uri("http://localhost")
        };
        _sut = new JsonWttrInWeatherService(_httpClient);
    }

    [Fact]
    public async Task GetWeatherAsync_SingleLocation_ReturnsWeatherData()
    {
        // Arrange
        var jsonResponse = @"{
            ""current_condition"": [
                {
                    ""temp_C"": ""20"",
                    ""weatherDesc"": [{""value"": ""Clear""}]
                }
            ],
            ""nearest_area"": [
                {
                    ""areaName"": [{""value"": ""Bensheim""}]
                }
            ]
        }";
        var locations = "Bensheim";

        SetupHttpResponse(jsonResponse);

        // Act
        var result = await _sut.GetWeatherAsync(locations);

        // Assert
        Assert.Equal("Bensheim", result.Location);
        Assert.Equal("20°C", result.Temperature);
        Assert.Equal("Clear", result.Condition);

        _mockHttpMessageHandler.Protected().Verify(
            "SendAsync",
            Times.Once(),
            ItExpr.IsAny<HttpRequestMessage>(),
            ItExpr.IsAny<CancellationToken>()
        );
    }

    [Fact]
    public async Task GetWeatherAsync_WithFormat_ReturnsWeatherData()
    {
        // Arrange
        var jsonResponse = @"{
            ""current_condition"": [
                {
                    ""temp_C"": ""20"",
                    ""weatherDesc"": [{""value"": ""Sunny""}]
                }
            ],
            ""nearest_area"": [
                {
                    ""areaName"": [{""value"": ""Bensheim""}]
                }
            ]
        }";
        var location = "Bensheim";
        SetupHttpResponse(jsonResponse);

        // Act
        var result = await _sut.GetWeatherAsync(location);
        // Assert
        Assert.Equal("Bensheim", result.Location);
        Assert.Equal("20°C", result.Temperature);
        Assert.Equal("Sunny", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_WithNullFormat_ReturnsWeatherData()
    {
        // Arrange
        var jsonResponse = @"{
            ""current_condition"": [
                {
                    ""temp_C"": ""18"",
                    ""weatherDesc"": [{""value"": ""Partly Cloudy""}]
                }
            ],
            ""nearest_area"": [
                {
                    ""areaName"": [{""value"": ""Bensheim""}]
                }
            ]
        }";
        var location = "Bensheim";

        SetupHttpResponse(jsonResponse);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Equal("Bensheim", result.Location);
        Assert.Equal("18°C", result.Temperature);
        Assert.Equal("Partly Cloudy", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_WithEmptyFormat_ReturnsWeatherData()
    {
        // Arrange
        var jsonResponse = @"{
            ""current_condition"": [
                {
                    ""temp_C"": ""22"",
                    ""weatherDesc"": [{""value"": ""Clear""}]
                }
            ],
            ""nearest_area"": [
                {
                    ""areaName"": [{""value"": ""Bensheim""}]
                }
            ]
        }";
        var location = "Bensheim";

        SetupHttpResponse(jsonResponse);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Equal("Bensheim", result.Location);
        Assert.Equal("22°C", result.Temperature);
        Assert.Equal("Clear", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_EmptyLocations_ReturnsWeatherData()
    {
        // Arrange
        var jsonResponse = @"{
            ""current_condition"": [
                {
                    ""temp_C"": ""19"",
                    ""weatherDesc"": [{""value"": ""Overcast""}]
                }
            ],
            ""nearest_area"": [
                {
                    ""areaName"": [{""value"": ""Unknown""}]
                }
            ]
        }";
        var location = string.Empty;

        SetupHttpResponse(jsonResponse);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Equal("Unknown", result.Location);
        Assert.Equal("19°C", result.Temperature);
        Assert.Equal("Overcast", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_HttpRequestThrowsException_ReturnsErrorWeatherData()
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
        Assert.Equal("Network Error", result.Location);
        Assert.Equal("N/A", result.Temperature);
        Assert.Equal("Failed to fetch weather", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_InvalidJson_ReturnsErrorWeatherData()
    {
        // Arrange
        var invalidJson = "{ invalid json }";
        var location = "Bensheim";

        SetupHttpResponse(invalidJson);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Equal("Invalid JSON", result.Location);
        Assert.Equal("N/A", result.Temperature);
        Assert.Equal("Failed to fetch weather", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_MissingRequiredFields_ReturnsErrorWeatherData()
    {
        // Arrange
        var incompleteJson = "{\"current_condition\": [], \"nearest_area\": []}";
        var location = "Bensheim";

        SetupHttpResponse(incompleteJson);

        // Act
        var result = await _sut.GetWeatherAsync(location);

        // Assert
        Assert.Equal("Invalid Data", result.Location);
        Assert.Equal("N/A", result.Temperature);
        Assert.Equal("Failed to fetch weather", result.Condition);
    }

    private void SetupHttpResponse(string responseContent)
    {
        var response = new HttpResponseMessage(HttpStatusCode.OK)
        {
            Content = new StringContent(responseContent, Encoding.UTF8, "application/json")
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
