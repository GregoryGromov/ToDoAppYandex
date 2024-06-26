//
//  TaskEditingView.swift
//  TodoAppYandex
//
//  Created by Григорий Громов on 24.06.2024.
//

import SwiftUI

struct TaskEditingView: View {
    
    @StateObject var viewModel = TaskEditingViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                textEditorSection
                    
                importanceAndDateSection
                
                deleteButtonSection
                

            }
            .listSectionSpacing(.compact)
            .navigationTitle("Дело")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Отменить")
                        .foregroundStyle(.blue)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Сохранить")
                        .foregroundStyle(.blue)
                        .fontWeight(.semibold)
                }
            }
            
            
        }
        
//  чтобы при нажатии в любую часть экрана прекращался ввод в TextEditor
        .onTapGesture {
            self.endEditing(true)
        }
        
    }
    
    
    var textEditorSection: some View {
        Section {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.text)
                    .frame(minHeight: 100)
                    .padding()
            }
        }
    }
    
    var importanceAndDateSection: some View {
        Section {
            HStack {
                Text("Важность")
                Spacer()

                Picker("", selection: $viewModel.selectedImportance) {
                    ForEach(Importance.allCases, id: \.self) { option in
                        viewModel.getPickerPreview(for: option)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 180)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Сделать до")
                    if viewModel.deadlineSet {
                        Text(viewModel.deadline.dayMonthYear)
                            .foregroundStyle(.blue)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .onTapGesture {
                                viewModel.showCalendar.toggle()
                            }
                    }
                    
                }
                
                Spacer()
                Toggle("", isOn: $viewModel.deadlineSet)
            }
            
            if viewModel.showCalendar {
                HStack {
                    DatePicker(
                        "Enter your birthday",
                        selection: $viewModel.deadline,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: 400)
                        
                    
                }
            }
        }
    }
    
    var deleteButtonSection: some View {
        Section {
            Button {
                
            } label: {
                HStack() {
                    Spacer()
                    Text("Удалить")
                    Spacer()
                }
            }
        }
    }
    
}

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force) }
    }
}

#Preview {
    TaskEditingView()
}