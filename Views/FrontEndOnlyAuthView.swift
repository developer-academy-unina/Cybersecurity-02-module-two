import SwiftUI

enum UserRole: String {
    case user
    case admin
}

struct AdminData: Decodable {
    let secretMessage: String
}

struct FrontendOnlyAuthView: View {
    @State private var role: UserRole = .user
    @State private var adminData: AdminData?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Frontend-Only Authorization 🔓⚠️")
                .font(.title2).bold()

            Text("Current Role: \(role.rawValue)")
                .foregroundStyle(.secondary)

            Button("Toggle Role (user/admin)") {
                role = (role == .user) ? .admin : .user
                adminData = nil
                errorMessage = nil
                isLoading = false
            }
            .buttonStyle(.borderedProminent)

            Divider()

            // ❌ Vulnerable UI-only gate
            if role == .admin {
                Button {
                    Task {
                        await getAdminData()
                    }
                } label: {
                    Text("Get Admin Data")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)
            }

            if isLoading {
                ProgressView("Loading admin data...")
            }

            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            if let adminData {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Admin Data:")
                        .font(.headline)
                    Text(adminData.secretMessage)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Spacer()
        }
        .padding()
    }

    @MainActor
    func getAdminData() async {
        guard !isLoading else { return }

        isLoading = true
        adminData = nil
        errorMessage = nil
        defer { isLoading = false }

        do {
            adminData = try await fetchAdminData()
        } catch {
            errorMessage = "Failed to load admin data"
        }
    }
}

func fetchAdminData() async throws -> AdminData {
    let url = URL(string: "https://mod2-server.onrender.com/admin/data")!
    let request = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: request)

    return try JSONDecoder().decode(AdminData.self, from: data)
}

#Preview {
    FrontendOnlyAuthView()
}
