import Foundation
import JWTDecode
import KeychainAccess

class TokenHandler {
	let key = Keychain(service: "com.todolist")
	public static let shared = TokenHandler()
	
	private init() {}
	
	
	func saveToken(token: String) {
		do {
			try key.set(token, key: "jwt_token")
		} catch {
			print("Failed to save token")
		}
	}
	
	func clearToken() {
		do {
			try key.remove("jwt_token")
		} catch {
			print("Failed to clear token")
		}
	}
	
	func retrieveToken() -> String? {
		do {
			return try key.get("jwt_token")
		} catch {
			print("Unable to retrieve token")
		}
		return nil
	}
	
	func isTokenExpired() -> Bool {
		do {
			guard retrieveToken() != nil else {
				return true
			}
			let jwt = try decode(jwt: retrieveToken() ?? "")
			
			if let exp = jwt.expiresAt {
				return exp > Date()
			} else {
				return false
			}
		} catch {
			return true
		}
	}
}
