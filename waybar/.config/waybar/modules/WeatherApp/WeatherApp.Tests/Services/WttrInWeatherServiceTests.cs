using System.Net;
using WeatherApp.Services;

namespace WeatherApp.Tests.Services;

public class WttrInWeatherServiceTests
{
    private sealed class StubHttpMessageHandler : HttpMessageHandler
    {
        private readonly Func<HttpRequestMessage, HttpResponseMessage> _handler;

        public StubHttpMessageHandler(Func<HttpRequestMessage, HttpResponseMessage> handler)
        {
            _handler = handler;
        }

        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            return Task.FromResult(_handler(request));
        }
    }

    [Fact]
    public async Task GetWeatherAsync_ReturnsWeatherData_OnValidResponse()
    {
        var handler = new StubHttpMessageHandler(_ =>
            new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StringContent("☀️+20°C|Sunny")
            });

        var client = new HttpClient(handler) { BaseAddress = new Uri("http://example.com/") };
        var service = new WttrInWeatherService(client);

        var result = await service.GetWeatherAsync("Paris");

        Assert.NotNull(result);
        Assert.Equal("Paris", result!.Location);
        Assert.Equal("☀️+20°C", result.Temperature);
        Assert.Equal("Sunny", result.Condition);
    }

    [Fact]
    public async Task GetWeatherAsync_ReturnsNull_OnEmptyResponse()
    {
        var handler = new StubHttpMessageHandler(_ =>
            new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StringContent("")
            });

        var client = new HttpClient(handler) { BaseAddress = new Uri("http://example.com/") };
        var service = new WttrInWeatherService(client);

        var result = await service.GetWeatherAsync("Paris");

        Assert.Null(result);
    }

    [Fact]
    public async Task GetWeatherAsync_ReturnsNull_OnInvalidFormat()
    {
        var handler = new StubHttpMessageHandler(_ =>
            new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StringContent("NoSeparatorHere")
            });

        var client = new HttpClient(handler) { BaseAddress = new Uri("http://example.com/") };
        var service = new WttrInWeatherService(client);

        var result = await service.GetWeatherAsync("Paris");

        Assert.Null(result);
    }

    [Fact]
    public async Task GetWeatherAsync_ReturnsNull_OnHttpRequestException()
    {
        var handler = new StubHttpMessageHandler(_ => throw new HttpRequestException("fail"));
        var client = new HttpClient(handler) { BaseAddress = new Uri("http://example.com/") };
        var service = new WttrInWeatherService(client);

        var result = await service.GetWeatherAsync("Paris");

        Assert.Null(result);
    }
}