using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using WeatherApp;
using WeatherApp.Models;
using WeatherApp.Services;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureServices(
        (context, services) =>
        {
            services.AddHttpClient<IWeatherService, WttrInWeatherService>(client =>
                client.BaseAddress = new Uri("https://wttr.in/")
            );
            services.Configure<WeatherSettings>(
                context.Configuration.GetSection("WeatherSettings")
            );
            services.AddSingleton(sp => sp.GetRequiredService<IOptions<WeatherSettings>>().Value);
            services.AddTransient<WeatherApplication>();
        }
    )
    .Build();

var app = host.Services.GetRequiredService<WeatherApplication>();
var result = await app.RunAsync();
Console.WriteLine(result);
