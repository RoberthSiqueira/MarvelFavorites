import CryptoKit
import Foundation

extension String {
    var md5: String {
        guard let data = self.data(using: .utf8) else { return String() }
        return Insecure.MD5.hash(data: data)
            .map { String(format: "%02x", $0) }
            .joined()
    }
}
