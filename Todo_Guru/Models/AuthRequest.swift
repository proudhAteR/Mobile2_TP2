import Foundation

struct AuthRequest: Encodable {
	let username: String
	let password: String

	init(username: String, password: String) {
		self.username = username
		self.password = password
	}
}
struct RegistrationRequest: Encodable {
	let name: String
	let username: String
	let password: String

	init(name: String, username: String, password: String) {
		self.name = name
		self.username = username
		self.password = password
	}
}
struct AuthResponse: Decodable {
	let accessToken: String
	let user: User
}
