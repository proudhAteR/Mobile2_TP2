import Foundation

struct User: Codable {
	var id: Int
	var name: String
	var username: String
	
	init(id: Int, name: String, username: String) {
		self.id = id
		self.name = name
		self.username = username
	}
}
