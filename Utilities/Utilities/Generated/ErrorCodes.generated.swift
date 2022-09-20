// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// Вспомогательная структура из енумераций, воссоздаваемая из apiErrors/{lang}/Localizable.strings
// Необходима для Type-safe сравнивания значения кода ошибки при получении результата запроса из сетевого слоя

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - AlfaMobile API error codes

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum ErrorCodes {

  public enum Api {
    public enum Auth {
      public enum Users {
        /// SMS code expired
        public static let smsExpired: String = "api.auth.users.smsExpired"
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

public extension ErrorCodes {
  static func getMessage(key: String) -> String? {
    let format = NSLocalizedString(
        key, tableName: "ApiLocalizable",
        bundle: Bundle(for: BundleToken.self),
        comment: "")
    let builtText = String(format: format, locale: Locale.current, arguments: [])
    if builtText == key {
        return nil
    }
    return builtText
  }
}

private final class BundleToken {}
