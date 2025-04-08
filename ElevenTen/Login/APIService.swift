import Foundation

class APIService {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: "https://cookbookserver-peut.onrender.com/cookbook/login") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }

        let loginRequest = LoginRequest(username: username, password: password)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(loginRequest)
            request.httpBody = jsonData
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("📤 Request JSON: \(jsonString)")
            }
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("❌ Error de conexión: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    print("❌ Respuesta inválida del servidor.")
                    completion(.failure(NSError(domain: "InvalidResponse", code: 500, userInfo: nil)))
                }
                return
            }

            print("📡 Código de respuesta HTTP: \(httpResponse.statusCode)")

            guard let data = data, !data.isEmpty else {
                DispatchQueue.main.async {
                    print("❌ La respuesta del servidor está vacía.")
                    completion(.failure(NSError(domain: "EmptyData", code: httpResponse.statusCode, userInfo: nil)))
                }
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("📩 Respuesta del servidor: \(responseString)")
            }

            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                DispatchQueue.main.async {
                    print("✅ Login exitoso: \(loginResponse)")
                    completion(.success(loginResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    print("❌ Error al decodificar JSON: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
