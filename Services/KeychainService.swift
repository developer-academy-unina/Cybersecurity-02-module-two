import Foundation
import LocalAuthentication
import Security

struct KeychainError: LocalizedError {
    let message: String

    var errorDescription: String? {
        message
    }
}

enum KeychainService {

    static func set(
        account: String,
        message: String
    ) throws {

        // Delete old item (if any)
        SecItemDelete(
            [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
            ] as CFDictionary
        )
        
        guard
            let accessControl = SecAccessControlCreateWithFlags(
                nil,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                .biometryCurrentSet,  // check FaceID each time
                nil
            )
        else {
            throw KeychainError(
                message:
                    "Biometric authentication is not available on this device."
            )
        }

        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrAccessControl as String: accessControl,
            kSecValueData as String: Data(message.utf8),
        ]

        // Set the item
        let status = SecItemAdd(attributes as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeychainError(
                message:
                    "Failed to save secure data (status: \(status))."
            )
        }
    }

    static func get(
        account: String,
    ) throws -> String {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
            let data = item as? Data
        else {
            throw KeychainError(
                message:
                    "Failed to read secure data (status: \(status))."
            )
        }

        return String(decoding: data, as: UTF8.self)
    }
}
