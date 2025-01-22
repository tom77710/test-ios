import Services
import UIKit

class PokemonViewModel {
    init() {}
    
    let networkService = NetworkService()
    var tableView: UITableView?
    var pokemons: [PokemonDetail] = []
    
    func fetch() {
        networkService.execute(with: URL(string: "https://pokeapi.co/api/v2/pokemon")!) { pokemon in
            let pokemon: Pokemon = pokemon
            guard let results = pokemon.results else { return }
            
            for result in results {
                self.networkService.execute(with: URL(string: result.url!)!) { detail in
                    let pokemonDetail: PokemonDetail = detail
                    self.pokemons.append(pokemonDetail)
                    //remove for crash
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    }
                }
            }
        }
    }
}
