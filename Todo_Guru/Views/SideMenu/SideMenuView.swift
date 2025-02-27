import SwiftUI

struct SideMenuView: View {
    @Binding var isPresented: Bool
    @Binding var selected: MenuOption

    private func hideMenu() {
        isPresented = false
    }

    private func handleSelection(option: MenuOption) {
        self.selected = option
    }

    @ViewBuilder
    private func menuOptionsList() -> some View {
        ForEach(MenuOption.allCases) { option in
            Button {
                handleSelection(option: option)
            } label: {
                SideMenuRowView(selected: $selected, option: option)
            }
        }
    }

    var body: some View {
        HeaderView(
            name: "\(UserDefaults.standard.string(forKey: "name") ?? "User")",
            username: "\(UserDefaults.standard.string(forKey: "username") ?? "Username")"
        )
            .padding(.bottom)

        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                menuOptionsList()
            }
        }
        .onChange(of: selected) { _, _ in
            hideMenu()
        }
    }
}

#Preview {
	HiddenMenuView(isPresented: .constant(true), selected: .constant(.tasks))
}
