import SwiftUI
//import LocalAuthentication

struct FaceIDDemo: View {
    @State private var secret = ""
    @State private var newSecret = ""
    @State private var errorMessage = ""

    private let account = "faceid-demo-secret"

    //    private let context = LAContext()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("Face ID Demo 🧑‍💻")
                .font(.title2)
                .bold()

            VStack(spacing: 20) {

                SecretBox(secret: secret)
                    .onTapGesture {
                        secret = ""
                    }

                Divider()

                VStack(spacing: 10) {
                    SecureField("Enter a secret to protect…", text: $newSecret)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 18))
                        .padding(4)

                    Button("Lock Secret") {
                        lock()
                        secret = ""
                    }
                    .disabled(newSecret.isEmpty)
                    .buttonStyle(.bordered)
                }

                Divider()

                Button("Unlock with Face ID") {
                    unlock()
                }
                .buttonStyle(.borderedProminent)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
        }
        .padding()
    }

    private func lock() {
        do {
            try KeychainService.set(
                account: account,
                message: newSecret,
            )
            newSecret = ""
            errorMessage = ""
            secret = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func unlock() {
        errorMessage = ""

        do {
            secret = try getItem()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func getItem() throws -> String {
        return try KeychainService.get(account: account)
    }

    //    private func getItem() async throws -> String {
    //        try await context.evaluatePolicy(
    //            .deviceOwnerAuthenticationWithBiometrics,
    //            localizedReason: "Unlock your protected secret"
    //        )
    //
    //        return try KeychainService.get(
    //            account: account,
    //            context: context
    //        )
    //    }
}

#Preview {
    FaceIDDemo()
}
