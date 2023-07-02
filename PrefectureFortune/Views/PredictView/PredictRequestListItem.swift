//
//  PredictRequestListItem.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct PredictRequestListItem: View {
    @FocusState private var focusedField: FocusedField?
    @Binding var person: Person
    var onChange: () -> Void
    
    enum FocusedField: Hashable {
        case name
    }
    
    var body: some View {
        VStack {
            Label {
                HStack {
                    TextField("Name", text: $person.name)
                        .focused($focusedField, equals: .name)
                        .onChange(of: person.name) { _ in
                            onChange()
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)){ obj in
                            // Process to select all text
                            if let textField = obj.object as? UITextField {
                                textField.selectedTextRange = textField.textRange(
                                    from: textField.beginningOfDocument,
                                    to: textField.endOfDocument
                                )
                            }
                        }
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.tertiary)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            focusedField = .name
                            person.name = ""
                        }
                }
            } icon: {
                icon(systemName: "person.fill", color: .blue)
            }
            .padding(.bottom, 4)
            
            Label {
                DatePicker("Birthday", selection: $person.birthday.date, displayedComponents: .date)
                    .onChange(of: person.birthday.date) { _ in
                        onChange()
                    }
            } icon: {
                icon(systemName: "birthday.cake.fill", color: .orange)
            }
            .padding(.bottom, 2)
            
            Label {
                Text("Blood Type")
                Spacer()
                Picker("Blood type", selection: $person.bloodType) {
                    ForEach(BloodType.allCases) { type in
                        Text(type.rawValue.uppercased()).tag(type.id)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: person.bloodType) { _ in
                    onChange()
                }
                .frame(maxWidth: 410)
            } icon: {
                icon(systemName: "drop.fill", color: .red)
            }
        }
    }
    
    private func icon(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .frame(width: 26, height: 26)
            .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .backgroundStyle(color.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1)))
    }
}

struct PredictRequestListItem_Previews: PreviewProvider {
    static var previews: some View {
        PredictRequestListItem(person: .constant(Person.preview)) {
            print("Changed")
        }
        .padding()
    }
}
