import SwiftUI

struct RootView: View {
	@State private var showMenu = false
	@State private var selected: MenuOption = .tasks
	@StateObject var vm = LoginViewModel()
	
	var auth: Bool {
		vm.loggedIn
	}
	
	private var current: some View {
		Group {
			if auth {
				selected.view
			} else {
				LoginView()
					.environmentObject(vm)
			}
		}
		.transition(.opacity)
	}
	var body: some View {
		NavigationStack {
			ZStack {
				VStack {
					current
				}
				HiddenMenuView(isPresented: $showMenu, selected: $selected)
			}
			
			.navigationTitle(selected.rawValue.capitalized)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					HiddenMenuButton(showMenu: $showMenu)
				}
			}
		}
	}
}

#Preview {
    RootView()
}

struct HiddenMenuButton: View {
	@Binding var showMenu: Bool
	var body: some View {
		Button(action: { showMenu.toggle() }) {
			Image(systemName: "line.3.horizontal")
		}
	}
}
