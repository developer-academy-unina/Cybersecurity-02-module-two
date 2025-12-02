import SwiftUI

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }

    struct Weather: Decodable {
        let description: String
    }
}

struct APIError: Decodable, Error {
    let message: String
}

struct WeatherLookupView: View {
    @State private var city = ""
    @State private var weatherResp: WeatherResponse?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Weather Lookup ☀️🌍🌦️🌎🌩️🌏❄️")
                .font(.title2).bold()

            Divider()

            TextField("Enter city", text: $city)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .font(.system(size: 22, weight: .medium))

            Button {
                Task {
                    await getWeather()
                }
            } label: {
                Text("Get Weather")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(city.isEmpty)

            if isLoading {
                ProgressView("Loading...")
            }

            if let weatherResp {
                WeatherCard(weatherResp: weatherResp)
            }

            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            Spacer()
        }
        .padding()
    }

    func getWeather() async {
        isLoading = true
        errorMessage = nil
        weatherResp = nil

        defer { isLoading = false }

        do {
            weatherResp = try await fetchWeatherResponse()
        } catch {
            errorMessage =
                (error as? APIError)?.message ?? "Could not load weather"
        }
    }

    func fetchWeatherResponse() async throws -> WeatherResponse {
        let urlString =
            "\(AppInfo.openWeatherURL)?q=\(city)&appid=\(AppInfo.openWeatherKey)&units=metric"

        let url = URL(string: urlString)!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse,
            http.statusCode == 200
        else {
            let apiError = try JSONDecoder().decode(APIError.self, from: data)
            throw apiError
        }

        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}

#Preview {
    WeatherLookupView()
}
