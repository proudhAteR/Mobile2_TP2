import Foundation

enum HTTPError: Error {
	case invalidURL
	case invalidResponse
	case invalidData
	case statusCode(Int)
	case unknownError(Error)
}

class APIClient {
	private let baseURL = "https://api-mobile.cegeplabs.qc.ca/"

	static let shared = APIClient()

	private init() {}

	func get<T: Decodable>(endpoint: String) async throws -> T {
		let urlString = baseURL + endpoint

		guard let url = URL(string: urlString) else {
			throw HTTPError.invalidURL
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request = addToken(to: request)

		let (data, response) = try await URLSession.shared.data(for: request)

		try validate(response: response)

		return try decode(data: data)
	}

	func post<T: Encodable, U: Decodable>(endpoint: String, authRequest: T)
		async throws -> U
	{
		let urlString = baseURL + endpoint

		guard let url = URL(string: urlString) else {
			throw HTTPError.invalidURL
		}

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request = addToken(to: request)

		let body = try encode(body: authRequest)

		request.httpBody = body

		let (data, response) = try await URLSession.shared.data(for: request)

		try validate(response: response)

		return try decode(data: data)
	}

	private func validate(response: URLResponse) throws {
		guard let httpResponse = response as? HTTPURLResponse else {
			throw HTTPError.invalidResponse
		}

		if !(200...299).contains(httpResponse.statusCode) {
			throw HTTPError.statusCode(httpResponse.statusCode)
		}
	}

	private func decode<T: Decodable>(data: Data) throws -> T {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase

		do {
			return try decoder.decode(T.self, from: data)
		} catch {
			throw HTTPError.invalidData
		}
	}

	private func encode<T: Encodable>(body: T) throws -> Data {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase

		do {
			return try encoder.encode(body)
		} catch {
			throw HTTPError.invalidResponse
		}
	}

	private func addToken(to request: URLRequest) -> URLRequest {
		var modifiedRequest = request
		let token = TokenHandler.shared.retrieveToken()

		modifiedRequest.addValue(
			"application/json", forHTTPHeaderField: "Content-Type")
		modifiedRequest
			.addValue(
				"Bearer \(String(describing: token))",
				forHTTPHeaderField: "Authorization"
			)
		return modifiedRequest
	}
}
