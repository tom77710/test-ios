import UIKit
import Services
import Combine

class PokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let viewModel = PokemonViewModel()
    let tableView = UITableView()

    override func viewDidLoad() {
        title = "Pokemons"
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.tableView = tableView
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        viewModel.fetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "poke")
        if cell == nil {
            cell = PokemonTableViewCell(style: .value1, reuseIdentifier: "poke")
        }
        
        let pokemon: PokemonDetail = viewModel.pokemons[indexPath.row]
        cell?.textLabel?.text = pokemon.name
        cell?.detailTextLabel?.text = pokemon.height.description
        cell?.imageView?.image = .init(data: try! .init(contentsOf: URL(string: pokemon.sprites.other!.officialArtwork.frontDefault)!))
        cell?.imageView?.backgroundColor = .lightGray
        cell?.imageView?.contentMode = .scaleAspectFit

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = PokemonDetailViewController(viewModel.pokemons[indexPath.row]) {
            self.navigationController?.dismiss(animated: true)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController?.present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

class PokemonTableViewCell: UITableViewCell {
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        imageView?.frame = CGRectMake(10,10,50,130)
    }
}
