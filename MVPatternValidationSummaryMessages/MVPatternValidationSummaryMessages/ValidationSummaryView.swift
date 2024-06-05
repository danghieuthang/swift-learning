//
//  ValidationSummaryView.swift
//  MVPatternValidationSummaryMessages
//
//  Created by Thắng Đặng on 6/5/24.
//

import SwiftUI

struct ValidationSummaryView: View {
    let errors: [LocalizedError]
    var body: some View {
        ForEach(errors, id: \.id) { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    ValidationSummaryView(errors: [])
}
