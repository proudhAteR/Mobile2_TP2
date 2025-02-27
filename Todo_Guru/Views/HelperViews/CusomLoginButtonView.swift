import SwiftUI

struct CusomLoginButtonView: View {
	var text: String
	var action: () -> Void = {}
	var color: Color = Color.accentColor
	var body: some View {
		Button(action: action) {
			Text(text)
				.font(.title2)
				.fontWeight(.heavy)
				.foregroundColor(.white)
				.frame(maxWidth: .infinity)
				.padding()
				.background(color)
				.cornerRadius(36)
		}
	}
}

#Preview {
	CusomLoginButtonView(text: "Preview")
}
