import Foundation

struct Entry: Codable { let date: String; let text: String }
let file = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("logbook.json")
let decoder = JSONDecoder(); let encoder = JSONEncoder(); encoder.outputFormatting = .prettyPrinted
var entries: [Entry] = (try? decoder.decode([Entry].self, from: Data(contentsOf: file))) ?? []
let args = Array(CommandLine.arguments.dropFirst())
switch args.first {
case "add":
    let text = args.dropFirst().joined(separator: " ").trimmingCharacters(in: .whitespaces)
    guard !text.isEmpty else { fatalError("Escribe una entrada") }
    entries.append(Entry(date: ISO8601DateFormatter().string(from: Date()), text: text)); try! encoder.encode(entries).write(to: file); print("Entrada guardada")
case "list": entries.forEach { print("\($0.date): \($0.text)") }
default: print("Uso: logbook add texto | list")
}
