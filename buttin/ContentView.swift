//
//  ContentView.swift
//  buttin
//
//

// MARK: - ContentView.swift (الكود المعدل)

// MARK: - ContentView.swift (الكود المعدل لاستخدام Sheet)

// MARK: - ContentView.swift (الكود المعدل لاستخدام Sheet)

// ContentView.swift

// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var showSetReminder = false
    @State private var plantToEdit: Plant? = nil // متغير فارغ (نبتة للتعديل لاحقًا)

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // العنوان
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
                
                // 🌿 الصورة بنفس القياسات الأصلية
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
                    .frame(height: 40)
                // زر بنفس التصميم الزجاجي الأصلي
                Button(action: {
                    showSetReminder = true
                    plantToEdit = nil // وضع إضافة جديدة
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("bottom")) // اللون الأصلي نفسه
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
                // ✅ الشيت مع القيم المطلوبة
                .sheet(isPresented: $showSetReminder) {
                    SetReminderView(
                        isPresented: $showSetReminder,
                        plantToEdit: $plantToEdit,
                        onSave: { name, room, light, waterAmount, _ in
                            print("✅ Saved new plant: \(name) - \(room) - \(light) - \(waterAmount)")
                        },
                        onDelete: {
                            print("🗑️ Deleted plant")
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
