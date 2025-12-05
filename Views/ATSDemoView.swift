import SwiftUI

struct ATSDemoView: View {
    @State private var result = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("ATS Demo 🔒")
                .font(.title2).bold()

            Divider()

            Button("Fetch over HTTP") {
                Task {
                    result = await fetchResult()
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)

            Text(result)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
    }

}

func fetchResult() async -> String {
    let url = URL(string: "http://badssl.com")!

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return "Succeeded: \(data.count) bytes"
    } catch {
        return error.localizedDescription
    }
}

#Preview {
    ATSDemoView()
}
