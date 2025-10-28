//
//  TodayReminderView.swift
//  buttin
//
//

// TodayReminderView.swift
import SwiftUI

// MARK: - Plant Model
struct Plant: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var room: String
    var light: String
    var waterAmount: String
    var isWatered: Bool = false
}

// MARK: - Progress Bar (الجديدة)
struct ProgressBarView: View {
    let wateredCount: Int
    let totalCount: Int

    var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(wateredCount) / Double(totalCount)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if wateredCount == 0 {
                Text("Your plants are waiting for a sip 💦")
                    .font(.headline)
                    .foregroundColor(.white)
            } else if wateredCount == totalCount {
                Text("All Done! 🎉")
                    .font(.headline)
                    .foregroundColor(Color("bottom"))
            } else {
                Text("\(wateredCount) of your plants feel loved today ✨")
                    .font(.headline)
                    .foregroundColor(.white)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("bottom"))
                        .frame(width: geometry.size.width * progress, height: 8)
                        .animation(.easeInOut(duration: 0.3), value: progress)
                }
            }
            .frame(height: 8)
        }
        .frame(height: 48)
    }
}

// MARK: - My Plants View
struct MyPlantsView: View {
    @State private var plants: [Plant] = []
    @State private var showingSetReminder = false
    @State private var selectedPlant: Plant? = nil
    @State private var showAllDone = false

    // عدد النباتات المسقاة
    var wateredPlantsCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                // ✅ شاشة All Done
                if showAllDone {
                    VStack(spacing: 0) {
                        // العنوان بنفس تصميم الشاشة الثانية
                        VStack(spacing: 12) {
                            Text("My Plants 🌱")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 50)
                                .padding(.leading, 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.7))
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, 20)

                        Spacer()

                        VStack(spacing: 20) {
                            Image("plant2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 315, height: 220)
                                .padding(.top, 40)
                            
                            Text("All Done! 🎉")
                                .font(.title.bold())
                                .foregroundColor(.white)

                            Text("All Reminders Completed")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        // زر الإضافة يبقى شغال
                        HStack {
                            Spacer()
                            Button {
                                selectedPlant = nil
                                showingSetReminder = true
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .frame(width: 55, height: 55)
                                    .background(Color("bottom"))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, 40)
                            .padding(.trailing, 20)
                        }
                    }
                }

                // ✅ شاشة البداية إذا ما فيه نباتات
                else if plants.isEmpty {
                    VStack(spacing: 0) {
                        // العنوان بنفس تصميم الشاشة الثانية
                        VStack(spacing: 12) {
                            Text("My Plants 🌱")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 50)
                                .padding(.leading, 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.7))
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, 20)
                        
                        // الصورة بنفس القياسات والتباعد
                        Image("plant")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 40)

                        Spacer()
                            .frame(height: 40)
                        
                        // النصوص بنفس التباعد
                        Text("Start your plant journey!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.bottom, 8)

                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 40)
                        
                        Spacer()

                        // زر بنفس التصميم الزجاجي الأصلي
                        Button(action: {
                            selectedPlant = nil
                            showingSetReminder = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color("bottom"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color.white.opacity(0.15))
                                            .blur(radius: 3)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                    )
                                    .frame(width: 299, height: 45)
                                
                                Text("Set Plant Reminder")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 150)

                        Spacer()
                    }
                }

                // ✅ شاشة النباتات (الرئيسية)
                else {
                    VStack(spacing: 0) {
                        // العنوان بنفس تصميم الشاشة الثانية
                        VStack(spacing: 12) {
                            Text("My Plants 🌱")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 50)
                                .padding(.leading, 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.7))
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, 20)

                        // ✅ البروغريس بار الجديدة
                        ProgressBarView(wateredCount: wateredPlantsCount, totalCount: plants.count)
                            .padding(.horizontal)
                            .padding(.bottom, 20)

                        // قائمة النباتات
                        List {
                            ForEach($plants) { $plant in
                                Button(action: {
                                    // الضغط للتعديل
                                    selectedPlant = plant
                                    showingSetReminder = true
                                }) {
                                    HStack(alignment: .top, spacing: 10) {
                                        // زر الصح
                                        Button(action: {
                                            withAnimation {
                                                plant.isWatered.toggle()
                                                if plants.allSatisfy({ $0.isWatered }) {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                        showAllDone = true
                                                    }
                                                }
                                            }
                                        }) {
                                            Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                                                .font(.title2)
                                                .foregroundColor(plant.isWatered ? Color("bottom") : .gray.opacity(0.8))
                                        }
                                        .buttonStyle(PlainButtonStyle())

                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(plant.name)
                                                .font(.title2)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)

                                            HStack(spacing: 15) {
                                                // الشمس باللون المطلوب #CCC785
                                                HStack(spacing: 4) {
                                                    Image(systemName: "sun.max")
                                                        .font(.caption)
                                                        .foregroundColor(Color(hex: "#CCC785"))
                                                    Text(plant.light)
                                                        .font(.caption)
                                                        .foregroundColor(Color(hex: "#CCC785"))
                                                }
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color(hex: "#18181D"))
                                                .cornerRadius(6)

                                                // القطرة باللون المطلوب #CAF3FB
                                                HStack(spacing: 4) {
                                                    Image(systemName: "drop")
                                                        .font(.caption)
                                                        .foregroundColor(Color(hex: "#CAF3FB"))
                                                    Text(plant.waterAmount)
                                                        .font(.caption)
                                                        .foregroundColor(Color(hex: "#CAF3FB"))
                                                }
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color(hex: "#18181D"))
                                                .cornerRadius(6)
                                            }

                                            HStack(spacing: 4) {
                                                Image(systemName: "paperplane")
                                                    .font(.caption2)
                                                    .foregroundColor(.gray)
                                                Text("in \(plant.room)")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.vertical, 12)
                                }
                                .listRowBackground(Color.black)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            }
                            .onDelete { indexSet in
                                plants.remove(atOffsets: indexSet)
                            }
                        }
                        .listStyle(.plain)

                        // زر الإضافة
                        HStack {
                            Spacer()
                            Button {
                                selectedPlant = nil
                                showingSetReminder = true
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .frame(width: 55, height: 55)
                                    .background(Color("bottom"))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, 40)
                            .padding(.trailing, 20)
                        }
                    }
                }
            }
            // ✅ صفحة الإضافة / التعديل
            .sheet(isPresented: $showingSetReminder) {
                SetReminderView(
                    isPresented: $showingSetReminder,
                    plantToEdit: $selectedPlant
                ) { name, room, light, waterAmount, isEdit in
                    if let index = plants.firstIndex(where: { $0.id == selectedPlant?.id }) {
                        // تعديل
                        plants[index].name = name
                        plants[index].room = room
                        plants[index].light = light
                        plants[index].waterAmount = waterAmount
                    } else {
                        // إضافة جديدة
                        let newPlant = Plant(name: name, room: room, light: light, waterAmount: waterAmount)
                        plants.append(newPlant)
                    }
                } onDelete: {
                    if let plant = selectedPlant {
                        plants.removeAll { $0.id == plant.id }
                    }
                }
            }
        }
    }
}

// MARK: - Hex Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}

#Preview {
    MyPlantsView()
}
