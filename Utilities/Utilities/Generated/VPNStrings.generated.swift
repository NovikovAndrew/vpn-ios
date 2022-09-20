// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum VPNLocale {
  // MARK: - Constants

  public enum Constants {
    public static let defaultTable: String = "Localizable"
  }

  public static var currentLanguageCode: String = Locale.current.languageCode ?? "ru"


  public enum Transfers {
    public enum Swift {
      public enum KnpHelp {
        /// Transfer Purpose Code
        public static let title: String = VPNLocale.tr("Localizable", "transfers.swift.knpHelp.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

public extension VPNLocale {
  static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let path = Bundle(for: BundleToken.self).path(forResource: VPNLocale.currentLanguageCode, ofType: "lproj")
    let bundle = Bundle(path: path!) ?? Bundle(for: BundleToken.self)
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
  static func tr(_ key: String) -> String {
    tr(Constants.defaultTable, key)
  }
}

private final class BundleToken {}
