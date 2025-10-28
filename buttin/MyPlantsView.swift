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

// MARK: - My Plants View
struct MyPlantsView: View {
    @State private var plants: [Plant] = []
    @State private var showingSetReminder = false
    @State private var selectedPlant: Plant? = nil
    @State private var showAllDone = false

    var wateredPlantsCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // ✅ شاشة All Done
            if showAllDone {
                VStack(spacing: 0) {
                    VStack(spacing: 12) {
                        Text("My Plants 🌱")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 50)
                            .padding(.leading, 20)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.7))
                            .frame(height: 0)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 20)

                    Spacer()

                    VStack(spacing: 20) {
                        Image("plant2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 40)

                        Text("All Done! 🎉")
                            .font(.title.bold())
                            .foregroundColor(.white)

                        Text("All Reminders Completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    HStack {
                        Spacer()
                        Button {
                            selectedPlant = nil
                            showAllDone = false
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
                    VStack(spacing: 12) {
                        Text("My Plants 🌱")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 50)
                            .padding(.leading, 20)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.7))
                            .frame(height: 0.3)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 20)
                    
                    Image("plant")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 40)

                    Spacer()
                        .frame(height: 40)
                    
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

                    Button(action: {
                        selectedPlant = nil
                        showingSetReminder = true
                    }) {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 299, height: 45)
                            .background(Color("bottom"))
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 150)

                    Spacer()
                }
            }
            // ✅ شاشة النباتات (الرئيسية)
            else {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(spacing: 12) {
                        Text("My Plants🌱")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.7))
                            .frame(height: 0.1)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 10)

                    VStack(alignment: .leading, spacing: 8) {
                        if wateredPlantsCount == 0 {
                            Text("Your plants are waiting for a sip 💦")
                                .font(.headline)
                                .foregroundColor(.white)
                        } else if wateredPlantsCount == plants.count {
                            Text("All Done! 🎉")
                                .font(.headline)
                                .foregroundColor(Color("bottom"))
                        } else {
                            Text("\(wateredPlantsCount) of your plants feel loved today ✨")
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
                                    .frame(width: geometry.size.width * (plants.isEmpty ? 0 : Double(wateredPlantsCount) / Double(plants.count)), height: 8)
                                    .animation(.easeInOut(duration: 0.3), value: wateredPlantsCount)
                            }
                        }
                        .frame(height: 8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)

                    List {
                        ForEach($plants) { $plant in
                            VStack(spacing: 0) {
                                Button(action: {
                                    selectedPlant = plant
                                    showingSetReminder = true
                                }) {
                                    HStack(alignment: .top, spacing: 10) {
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
                                        .padding(.trailing, 8)

                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(plant.name)
                                                .font(.title2)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)

                                            HStack(spacing: 15) {
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
                                    .padding(.horizontal, 16)
                                }
                                
                                Divider()
                                    .background(Color.gray.opacity(0.3))
                            }
                            .listRowBackground(Color.black)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }
                        .onDelete { indexSet in
                            plants.remove(atOffsets: indexSet)
                        }
                    }
                    .listStyle(.plain)

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
        .sheet(isPresented: $showingSetReminder) {
            SetReminderView(
                isPresented: $showingSetReminder,
                plantToEdit: $selectedPlant
            ) { name, room, light, waterAmount, isEdit in
                if let index = plants.firstIndex(where: { $0.id == selectedPlant?.id }) {
                    plants[index].name = name
                    plants[index].room = room
                    plants[index].light = light
                    plants[index].waterAmount = waterAmount
                } else {
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
