import Foundation

final class ObraRepository {
    static let shared = ObraRepository()

    private var cache: [ObraDeArte]?

    private init() {}

    func carregarObras() -> [ObraDeArte] {
        if let cache { return cache }

        guard let url = Bundle.main.url(forResource: "obras", withExtension: "json") else {
            print("obras.json não encontrado no bundle")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let obras = try JSONDecoder().decode([ObraDeArte].self, from: data)
            cache = obras
            return obras
        } catch {
            print("falha ao carregar obras.json: \(error)")
            return []
        }
    }
}
