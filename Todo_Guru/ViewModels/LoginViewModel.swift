import Foundation

class LoginViewModel: ObservableObject {
	@Published var username: String = ""
	@Published var name: String = ""
	@Published var password: String = ""
	@Published var loggedUser: User?
	@Published var loggedIn: Bool
	private let client: AuthClient

	init(client: AuthClient = AuthClient()) {
		self.client = client
		self.loggedIn = false
		
		Task {
			await checkTokenStatus()
		}

		
		Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { _ in
			Task {
				await self.checkTokenStatus()
			}
		}
	}

	@MainActor
	func login() async {
		do {
			let response = try await client.login(
				username: username,
				password: password
			)
			
			self.loggedUser = response.user
			self.loggedIn = true
			
			TokenHandler.shared.saveToken(token: response.accessToken)
			
			UserDefaults.standard.set(self.loggedUser?.name, forKey: "name")
			UserDefaults.standard.set(self.loggedUser?.username, forKey: "username")
		} catch {
			print("Error while logging in: \(error)")
		}
	}
	
	@MainActor
	func checkTokenStatus() {
		if TokenHandler.shared.isTokenExpired() {
			logout()
		} else {
			if TokenHandler.shared.retrieveToken() != nil {
				self.loggedIn = true
			}
		}
	}
	
	@MainActor
	func logout() {
		loggedUser = nil
		loggedIn = false
		TokenHandler.shared.clearToken()
		
		UserDefaults.standard.removeObject(forKey: "name")
		UserDefaults.standard.removeObject(forKey: "username")
		
		print("User logged out due to expired token.")
	}

	func register() async {
		do {
			let response = try await client.register(
				name: username,
				username: username,
				password: password
			)
			self.name = response.user.name
			self.username = response.user.username

			await login()
		} catch {
			print("Error while registering: \(error)")
		}
	}
}
