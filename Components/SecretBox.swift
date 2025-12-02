import SwiftUI

struct SecretBox: View {
    let secret: String?

    var body: some View {
        Text(secret?.isEmpty == false ? secret! : "🔓")
            .font(.title3)
            .multilineTextAlignment(.center)
            .foregroundColor(secret?.isEmpty == false ? .primary : .secondary)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray3), lineWidth: 1)
            )
            .opacity(secret?.isEmpty == false ? 1 : 0.6)
    }
}
