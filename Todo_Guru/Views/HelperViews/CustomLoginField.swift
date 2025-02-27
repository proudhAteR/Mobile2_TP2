import SwiftUI

struct CustomLoginField: View {
	@Binding var data: String
	@State var title: String?
	@State var isSecure: Bool = false
	
	@ViewBuilder
	private var inputField: some View {
		if isSecure {
			SecureField("", text: $data)
		} else {
			TextField("", text: $data)
		}
	}
	var body: some View {
		ZStack {
			inputField
				.padding(.horizontal, 10)
				.frame(height: 54)
				.overlay(
					RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
						.stroke(Color.gray, lineWidth: 1)
				)
			HStack {
				FieldTitleView(title: $title)
				Spacer()
			}
			.padding(.leading, 8)
			.offset(CGSize(width: 0, height: -28))
		}.padding(4)
	}
	
}

#Preview {
	@Previewable @State var data: String = ""
	CustomLoginField(data: $data)
}

struct FieldTitleView: View {
	@Binding var title: String?
	var body: some View {
		Text(title ?? "Input")
			.font(.headline)
			.fontWeight(.regular)
			.foregroundColor(Color.gray)
			.multilineTextAlignment(.leading)
			.padding(4)
			.background(Color(.systemBackground))
	}
}
