//
//  TaskListView.swift
//  Session09
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tarea.nombre, ascending: true)],
        animation: .default
    ) private var tasks: FetchedResults<Tarea>
    
    @StateObject private var viewModel = TaskViewModel(context: Persistence.shared.container.viewContext)
    @State private var isShowingAddTask = false

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    TaskItemView(task: task)
                }
                .onDelete { indexSet in
                    indexSet.forEach { viewModel.deleteTask(task: tasks[$0]) }
                }
            }
//            .listStyle(PlainListStyle())
            .navigationTitle("Mis Tareas")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddTask = true
                    } label: {
                        Label("Agregar", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

struct TaskItemView: View {
    let task: Tarea

    var body: some View {
        HStack {
            Image(systemName: task.completado ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.completado ? .green : .gray)
                .font(.title2)

            VStack(alignment: .leading) {
                Text(task.nombre ?? "Sin nombre")
                    .font(.headline)
                Text(task.descripcion ?? "Sin descripción")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Label(task.prioridad ?? "N/A", systemImage: "flag.fill")
                        .foregroundColor(getPriorityColor(task.prioridad))
                    Text("•")
                    Text("Categoría: \(task.categoria ?? "N/A")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        .shadow(radius: 1)
        .padding(.vertical, 4)
    }

    func getPriorityColor(_ priority: String?) -> Color {
        switch priority {
        case "Alta": return .red
        case "Media": return .orange
        case "Baja": return .green
        default: return .gray
        }
    }
}
