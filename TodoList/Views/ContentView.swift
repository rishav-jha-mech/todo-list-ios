import SwiftUI

struct ContentView: View {
    @State private var store = TodoStore()
    @State private var newTitle: String = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("Add a task", text: $newTitle)
                            .onSubmit(addTodo)
                        Button(action: addTodo) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }

                Section {
                    ForEach(store.items) { item in
                        TodoRow(item: item) {
                            store.toggle(item)
                        }
                    }
                    .onDelete(perform: store.delete)
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                EditButton()
            }
        }
    }

    private func addTodo() {
        store.add(title: newTitle)
        newTitle = ""
    }
}

private struct TodoRow: View {
    let item: TodoItem
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.isDone ? .green : .secondary)
                Text(item.title)
                    .strikethrough(item.isDone)
                    .foregroundStyle(item.isDone ? .secondary : .primary)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ContentView()
}
