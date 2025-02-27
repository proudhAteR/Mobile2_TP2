import SwiftUI

struct HeaderView: View {
    var name: String
    var username: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.accentColor)
                        .frame(width: 32, height: 32)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text("\(name)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Text("\(username)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12).fill(
                Color(.systemBackground)
                    .opacity(0.75)
            )
        )
    }
}

#Preview {
    HeaderView(name: "1", username: "2")
}
