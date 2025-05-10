

import SwiftUI

struct GraphicalDatePicker: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Select Date")
                .font(.headline)
                .padding()

            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button("Done") {
                dismiss()
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(15)
        }
        .padding()
    }
}
