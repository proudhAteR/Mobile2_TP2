import SwiftUI

struct SideMenuRowView: View {
    @Binding var selected: MenuOption
    let option: MenuOption
    private var isSelected: Bool {
        selected == option
    }
    var body: some View {
        HStack {
			option.img
                .imageScale(.small)

            Text(option.rawValue.capitalized)
                .font(.subheadline)

            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? Color.accentColor : .primary)
        .frame(width: 216, height: 44)
        .background(isSelected ? Color.accentColor.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
	SideMenuRowView(selected: .constant(.group), option: MenuOption.group)
}
