import FancyText
import SwiftUI

struct FancyTextView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            Text("FancyText Demo ✨")
                .font(.title2)
                .bold()
            
            Divider()

            Text("This is boring text.")
                .font(.largeTitle)

            FancyText("This is FancyText!!")
                .padding(.top, 8)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FancyTextView()
}
