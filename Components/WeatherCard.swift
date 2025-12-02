import SwiftUI

struct WeatherCard: View {
    let weatherResp: WeatherResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("City: \(weatherResp.name)")
                .font(.headline)

            Text("Current: \(Int(weatherResp.main.temp))°C")

            Text(
                "High: \(Int(weatherResp.main.temp_max))°C ::: Low: \(Int(weatherResp.main.temp_min))°C"
            )

            Text(
                "Description: \(weatherResp.weather.first?.description.capitalized ?? "")"
            )
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
