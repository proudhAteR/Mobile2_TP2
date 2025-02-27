import SwiftUI

struct LoginView: View {
	@StateObject var vm = LoginViewModel()
	@State var show = false
	var body: some View {
		VStack(spacing: 60) {
			Text("Welcome Back")
				.font(.largeTitle)
				.fontWeight(.black)
			LoginFieldsView(username: $vm.username, password: $vm.password)
			CusomLoginButtonView(text: "Login") {
				Task {
					await vm.login()
				}
			}
			HStack {
				Spacer()
				Button(action: {
					show = true
				}) {
					Text("Register")
						.foregroundColor(.blue)
						.underline()
				}
			}
			.padding(.horizontal, 16)
		}.padding(16)
			.background(.clear)
			.sheet(isPresented: $show) {
				RegistrationView(vm: vm)
			}
	}
}

#Preview {
	LoginView()
}

struct LoginFieldsView: View {
	@Binding var username: String
	@Binding var password: String
	var body: some View {
		VStack(spacing: 24) {
			CustomLoginField(data: $username, title: "Username")
				.autocapitalization(.none)
				.disableAutocorrection(true)
			CustomLoginField(data: $password, title: "Password", isSecure: true)
				.autocapitalization(.none)
				.disableAutocorrection(true)
		}
	}
}

struct RegistrationView: View {
	@StateObject var vm: LoginViewModel
	var body: some View {
		VStack(spacing: 60) {
			Text("Welcome")
				.font(.largeTitle)
				.fontWeight(.black)
			RegistrationFieldsView(vm: vm)
			CusomLoginButtonView(text: "Register") {
				Task {
					await vm.register()
				}
			}

		}.padding(16)
	}
}

struct RegistrationFieldsView: View {
	@StateObject var vm: LoginViewModel
	var body: some View {
		VStack(spacing: 40) {
			CustomLoginField(data: $vm.name, title: "Name")
			CustomLoginField(data: $vm.username, title: "Username")
				.autocapitalization(.none)
				.disableAutocorrection(true)
			CustomLoginField(
				data: $vm.password,
				title: "Password",
				isSecure: true
			)
			.autocapitalization(.none)
			.disableAutocorrection(true)
		}
	}
}
