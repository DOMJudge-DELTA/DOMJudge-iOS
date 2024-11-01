import Foundation
import Security

class DOMJudgeLoginManager {

    var baseURL: String {
        return UserDefaults.standard.string(forKey: "DOMJudgeBaseURL") ?? ""
    }

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return }
        let base64LoginString = loginData.base64EncodedString()

        guard let url = URL(string: "\(baseURL)/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response here
        }
        task.resume()
    }
}
