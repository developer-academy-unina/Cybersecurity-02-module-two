import Foundation

struct AppInfo {
    static var openWeatherURL: String {
        Bundle.main.object(forInfoDictionaryKey: "OPEN_WEATHER_URL") as? String ?? ""
    }
    static var openWeatherKey: String {
        Bundle.main.object(forInfoDictionaryKey: "OPEN_WEATHER_KEY") as? String ?? ""
    }
}
