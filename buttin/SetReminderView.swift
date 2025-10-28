//
//  SetReminderView.swift
//  buttin
//
//  Created by RENAD MAJED ALSHAHRANY  on 01/05/1447 AH.
//

// SetReminderView.swift

// SetReminderView.swift

// SetReminderView.swift

import SwiftUI

struct SetReminderView: View {
    @Binding var isPresented: Bool
    @Binding var plantToEdit: Plant?

    var onSave: (String, String, String, String, Bool) -> Void
    var onDelete: () -> Void

    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"

    var isEditing: Bool {
        plantToEdit != nil
    }

    var body: some View {
        NavigationStack {
            List {
                // 🌿 اسم النبتة
                Section {
                    ZStack(alignment: .leading) {
                        if plantName.isEmpty {
                            Text("Plant Name")
                                .foregroundColor(.white.opacity(0.3))
                        }
                        TextField("", text: $plantName)
                            .foregroundColor(.white)
                            .keyboardType(.asciiCapable)
                    }
                }
                .listRowBackground(Color.customDarkGray)

                // 🏡 الغرفة والإضاءة
                Section {
                    pickerRow(icon: "paperplane", label: "Room", selection: $selectedRoom,
                              options: ["Living Room", "Bedroom", "Kitchen", "Balcony", "Bathroom"])
                    pickerRow(icon: lightIcon(for: selectedLight), label: "Light", selection: $selectedLight,
                              options: ["Full sun", "Partial sun", "Low Light"])
                }
                .listRowBackground(Color.customDarkGray)

                // 💧 السقي والماء
                Section {
                    pickerRow(icon: "drop", label: "Watering Days", selection: $selectedWateringDays,
                              options: ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"])
                    pickerRow(icon: "drop", label: "Water", selection: $selectedWaterAmount,
                              options: ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"])
                }
                .listRowBackground(Color.customDarkGray)

                // 🗑️ زر الحذف يظهر فقط في وضع التعديل
                if isEditing {
                    Section {
                        Button(role: .destructive) {
                            onDelete()
                            isPresented = false
                        } label: {
                            HStack {
                                Spacer()
                                Text("Delete Reminder")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                    .listRowBackground(Color.customDarkGray)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(hex: "#1C1E1D").ignoresSafeArea())
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)

            // ✅ أزرار الأعلى
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        onSave(plantName, selectedRoom, selectedLight, selectedWaterAmount, isEditing)
                        isPresented = false
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                       .tint(Color("bottom")
                       )}
                    
                }
            }

            // تحميل بيانات النبتة إذا كنا في وضع التعديل
            .onAppear {
                if let plant = plantToEdit {
                    plantName = plant.name
                    selectedRoom = plant.room
                    selectedLight = plant.light
                    selectedWaterAmount = plant.waterAmount
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - صف اختيار القيم
    private func pickerRow(icon: String, label: String, selection: Binding<String>, options: [String]) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(label)
                .foregroundColor(.white)
            Spacer()
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) { selection.wrappedValue = option }
                }
            } label: {
                HStack {
                    Text(selection.wrappedValue)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption2)
                }
                .foregroundColor(.gray)
            }
        }
    }

    // MARK: - اختيار أيقونة الإضاءة
    private func lightIcon(for light: String) -> String {
        switch light {
        case "Full sun": return "sun.max.fill"
        case "Partial sun": return "sun.min.fill"
        case "Low Light": return "sun.haze.fill"
        default: return "sun.max"
        }
    }
}

// MARK: - لون الخلفية الداكنة فقط
extension Color {
    static let customDarkGray = Color(red: 0.1, green: 0.1, blue: 0.1)
}

#Preview {
    SetReminderView(
        isPresented: .constant(true),
        plantToEdit: .constant(nil),
        onSave: { _, _, _, _, _ in },
        onDelete: {}
    )
}
