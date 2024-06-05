//
//  LoginView.swift
//  MVPatternValidationSummaryMessages
//
//  Created by Thắng Đặng on 6/5/24.
//

import SwiftUI

enum LoginError: LocalizedError, Identifiable {
    case emailEmpty
    case emailInvalid
    case passwordEmpty
    var id: Int {
        hashValue
    }

    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email cannot be empty"
        case .emailInvalid:
            return "Email is not in correct format"
        case .passwordEmpty:
            return "Password cannot be empty"
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errors: [LoginError] = []

    var isValid: Bool {
        errors = []
        if email.isEmpty {
            errors.append(.emailEmpty)
        } else if !email.isValidEmail {
            errors.append(.emailInvalid)
        }
        if password.isEmpty {
            errors.append(.passwordEmpty)
        }
        return errors.isEmpty
    }

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $password)
            Button("Login") {
                if isValid {
                    print("submit form")
                }
            }
            ValidationSummaryView(errors: errors)
        }
    }
}

#Preview {
    LoginView()
}
