import Foundation

class AuthClient {

	func login(username: String, password: String) async throws -> AuthResponse
	{
		let request = AuthRequest(username: username, password: password)

		let response: AuthResponse = try await APIClient.shared.post(
			endpoint: "todo/login",
			authRequest: request
		)
		print(response)
		return response
	}

	func register(name: String, username: String, password: String) async throws
		-> AuthResponse
	{
		let request = RegistrationRequest(
			name: name,
			username: username,
			password: password
		)

		let response: AuthResponse = try await APIClient.shared.post(
			endpoint: "todo/register",
			authRequest: request
		)
		return response
	}
}
