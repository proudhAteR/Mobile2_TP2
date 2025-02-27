import SwiftUI

struct HiddenMenuView: View {
    @Binding var isPresented: Bool
    @Binding var selected: MenuOption

    var body: some View {
        ZStack {
            SideMenuSafeZoneView(isPresented: $isPresented)

            HStack {
                VStack(alignment: .leading, spacing: 32) {
                    SideMenuView(
                        isPresented: $isPresented,
                        selected: $selected
                    )
                    Spacer()
                }
                .padding()
                .frame(width: 280, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .offset(x: isPresented ? 0 : -400)
                .animation(.easeInOut(duration: 0.25), value: isPresented)
                Spacer()
            }
        }

    }
}

struct SideMenuSafeZoneView: View {
    @Binding var isPresented: Bool
    var body: some View {
        Color.black.opacity(isPresented ? 0.3 : 0)
            .ignoresSafeArea()
            .onTapGesture {
                isPresented.toggle()
            }
    }
}
