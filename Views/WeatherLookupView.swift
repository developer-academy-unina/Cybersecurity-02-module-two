import Foundation
import SwiftUI

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
                .font(.system(size: 24, weight: .medium))
                .frame(height: 40)

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

    @MainActor
    func getWeather() async {
        isLoading = true
        errorMessage = nil
        weatherResp = nil

        defer { isLoading = false }

        do {
            weatherResp = try await fetchWeatherResponse(city: city)
        } catch {
            errorMessage =
                (error as? APIError)?.message ?? "Could not load weather"
        }
    }
}

func fetchWeatherResponse(city: String) async throws -> WeatherResponse {
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

#Preview {
    WeatherLookupView()
}
