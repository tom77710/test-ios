import Foundation

// MARK: - Pokemon
public struct Pokemon : Codable {
    public let count : Int?
    public let next : String?
    public let previous : String?
    public let results : [Results]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }
}

public struct Results : Codable {
    public let name : String?
    public let url : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case url = "url"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

// MARK: - PokemonDetail
public struct PokemonDetail: Decodable {
    public let abilities: [Ability]
    public let baseExperience: Int
    public let cries: Cries
    public let forms: [Species]
    public let gameIndices: [GameIndex]
    public let height: Int
    public let id: Int
    public let isDefault: Bool
    public let locationAreaEncounters: String
    public let moves: [Move]
    public let name: String
    public let order: Int
    public let species: Species
    public let sprites: Sprites
    public let stats: [Stat]
    public let types: [TypeElement]
    public let weight: Int

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case cries, forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case pastAbilities = "past_abilities"
        case pastTypes = "past_types"
        case species, sprites, stats, types, weight
    }

    public init(abilities: [Ability], baseExperience: Int, cries: Cries, forms: [Species], gameIndices: [GameIndex], height: Int, id: Int, isDefault: Bool, locationAreaEncounters: String, moves: [Move], name: String, order: Int, species: Species, sprites: Sprites, stats: [Stat], types: [TypeElement], weight: Int) {
        self.abilities = abilities
        self.baseExperience = baseExperience
        self.cries = cries
        self.forms = forms
        self.gameIndices = gameIndices
        self.height = height
        self.id = id
        self.isDefault = isDefault
        self.locationAreaEncounters = locationAreaEncounters
        self.moves = moves
        self.name = name
        self.order = order
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.types = types
        self.weight = weight
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        abilities = try container.decode([Ability].self, forKey: .abilities)
        baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        cries = try container.decode(Cries.self, forKey: .cries)
        forms = try container.decode([Species].self, forKey: .forms)
        gameIndices = try container.decode([GameIndex].self, forKey: .gameIndices)
        height = try container.decode(Int.self, forKey: .height)
        id = try container.decode(Int.self, forKey: .id)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
        locationAreaEncounters = try container.decode(String.self, forKey: .locationAreaEncounters)
        moves = try container.decode([Move].self, forKey: .moves)
        name = try container.decode(String.self, forKey: .name)
        order = try container.decode(Int.self, forKey: .order)
        species = try container.decode(Species.self, forKey: .species)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        stats = try container.decode([Stat].self, forKey: .stats)
        types = try container.decode([TypeElement].self, forKey: .types)
        weight = try container.decode(Int.self, forKey: .weight)
    }
}

// MARK: - Ability
public struct Ability: Codable {
    public let ability: Species
    public let isHidden: Bool
    public let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }

    public init(ability: Species, isHidden: Bool, slot: Int) {
        self.ability = ability
        self.isHidden = isHidden
        self.slot = slot
    }
}

// MARK: - Species
public struct Species: Codable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - Cries
public struct Cries: Codable {
    public let latest, legacy: String

    public init(latest: String, legacy: String) {
        self.latest = latest
        self.legacy = legacy
    }
}

// MARK: - GameIndex
public struct GameIndex: Codable {
    public let gameIndex: Int
    public let version: Species

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }

    public init(gameIndex: Int, version: Species) {
        self.gameIndex = gameIndex
        self.version = version
    }
}

// MARK: - Move
public struct Move: Codable {
    public let move: Species
    public let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }

    public init(move: Species, versionGroupDetails: [VersionGroupDetail]) {
        self.move = move
        self.versionGroupDetails = versionGroupDetails
    }
}

// MARK: - VersionGroupDetail
public struct VersionGroupDetail: Codable {
    public let levelLearnedAt: Int
    public let moveLearnMethod, versionGroup: Species

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }

    public init(levelLearnedAt: Int, moveLearnMethod: Species, versionGroup: Species) {
        self.levelLearnedAt = levelLearnedAt
        self.moveLearnMethod = moveLearnMethod
        self.versionGroup = versionGroup
    }
}

// MARK: - GenerationV
public struct GenerationV: Codable {
    public let blackWhite: Sprites

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }

    public init(blackWhite: Sprites) {
        self.blackWhite = blackWhite
    }
}

// MARK: - GenerationIv
public struct GenerationIv: Codable {
    public let diamondPearl, heartgoldSoulsilver, platinum: Sprites

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }

    public init(diamondPearl: Sprites, heartgoldSoulsilver: Sprites, platinum: Sprites) {
        self.diamondPearl = diamondPearl
        self.heartgoldSoulsilver = heartgoldSoulsilver
        self.platinum = platinum
    }
}

// MARK: - Versions
public struct Versions: Codable {
    public let generationI: GenerationI
    public let generationIi: GenerationIi
    public let generationIii: GenerationIii
    public let generationIv: GenerationIv
    public let generationV: GenerationV
    public let generationVi: [String: Home]
    public let generationVii: GenerationVii
    public let generationViii: GenerationViii

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }

    public init(generationI: GenerationI, generationIi: GenerationIi, generationIii: GenerationIii, generationIv: GenerationIv, generationV: GenerationV, generationVi: [String: Home], generationVii: GenerationVii, generationViii: GenerationViii) {
        self.generationI = generationI
        self.generationIi = generationIi
        self.generationIii = generationIii
        self.generationIv = generationIv
        self.generationV = generationV
        self.generationVi = generationVi
        self.generationVii = generationVii
        self.generationViii = generationViii
    }
}

// MARK: - Other
public struct Other: Codable {
    public let dreamWorld: DreamWorld
    public let home: Home
    public let officialArtwork: OfficialArtwork
    public let showdown: Sprites

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
        case showdown
    }

    public init(dreamWorld: DreamWorld, home: Home, officialArtwork: OfficialArtwork, showdown: Sprites) {
        self.dreamWorld = dreamWorld
        self.home = home
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
}

// MARK: - Sprites
public class Sprites: Codable {
    public let backDefault: String
    public let backFemale: String?
    public let backShiny: String
    public let backShinyFemale: String?
    public let frontDefault: String
    public let frontFemale: String?
    public let frontShiny: String
    public let frontShinyFemale: String?
    public let other: Other?
    public let versions: Versions?
    public let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }

    public init(backDefault: String, backFemale: String?, backShiny: String, backShinyFemale: String?, frontDefault: String, frontFemale: String?, frontShiny: String, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

// MARK: - GenerationI
public struct GenerationI: Codable {
    public let redBlue, yellow: RedBlue

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }

    public init(redBlue: RedBlue, yellow: RedBlue) {
        self.redBlue = redBlue
        self.yellow = yellow
    }
}

// MARK: - RedBlue
public struct RedBlue: Codable {
    public let backDefault, backGray, backTransparent, frontDefault: String
    public let frontGray, frontTransparent: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
        case frontTransparent = "front_transparent"
    }

    public init(backDefault: String, backGray: String, backTransparent: String, frontDefault: String, frontGray: String, frontTransparent: String) {
        self.backDefault = backDefault
        self.backGray = backGray
        self.backTransparent = backTransparent
        self.frontDefault = frontDefault
        self.frontGray = frontGray
        self.frontTransparent = frontTransparent
    }
}

// MARK: - GenerationIi
public struct GenerationIi: Codable {
    public let crystal: Crystal
    public let gold, silver: Gold

    public init(crystal: Crystal, gold: Gold, silver: Gold) {
        self.crystal = crystal
        self.gold = gold
        self.silver = silver
    }
}

// MARK: - Crystal
public struct Crystal: Codable {
    public let backDefault, backShiny, backShinyTransparent, backTransparent: String
    public let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backShinyTransparent = "back_shiny_transparent"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyTransparent = "front_shiny_transparent"
        case frontTransparent = "front_transparent"
    }

    public init(backDefault: String, backShiny: String, backShinyTransparent: String, backTransparent: String, frontDefault: String, frontShiny: String, frontShinyTransparent: String, frontTransparent: String) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.backShinyTransparent = backShinyTransparent
        self.backTransparent = backTransparent
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
        self.frontShinyTransparent = frontShinyTransparent
        self.frontTransparent = frontTransparent
    }
}

// MARK: - Gold
public struct Gold: Codable {
    public let backDefault, backShiny, frontDefault, frontShiny: String
    public let frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontTransparent = "front_transparent"
    }

    public init(backDefault: String, backShiny: String, frontDefault: String, frontShiny: String, frontTransparent: String?) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
        self.frontTransparent = frontTransparent
    }
}

// MARK: - GenerationIii
public struct GenerationIii: Codable {
    public let emerald: OfficialArtwork
    public let fireredLeafgreen, rubySapphire: Gold

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }

    public init(emerald: OfficialArtwork, fireredLeafgreen: Gold, rubySapphire: Gold) {
        self.emerald = emerald
        self.fireredLeafgreen = fireredLeafgreen
        self.rubySapphire = rubySapphire
    }
}

// MARK: - OfficialArtwork
public struct OfficialArtwork: Codable {
    public let frontDefault, frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    public init(frontDefault: String, frontShiny: String) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}

// MARK: - Home
public struct Home: Codable {
    public let frontDefault: String
    public let frontFemale: String?
    public let frontShiny: String
    public let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }

    public init(frontDefault: String, frontFemale: String?, frontShiny: String, frontShinyFemale: String?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
}

// MARK: - GenerationVii
public struct GenerationVii: Codable {
    public let icons: DreamWorld
    public let ultraSunUltraMoon: Home

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }

    public init(icons: DreamWorld, ultraSunUltraMoon: Home) {
        self.icons = icons
        self.ultraSunUltraMoon = ultraSunUltraMoon
    }
}

// MARK: - DreamWorld
public struct DreamWorld: Codable {
    public let frontDefault: String
    public let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }

    public init(frontDefault: String, frontFemale: String?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
    }
}

// MARK: - GenerationViii
public struct GenerationViii: Codable {
    public let icons: DreamWorld

    public init(icons: DreamWorld) {
        self.icons = icons
    }
}

// MARK: - Stat
public struct Stat: Codable {
    public let baseStat, effort: Int
    public let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }

    public init(baseStat: Int, effort: Int, stat: Species) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
}

// MARK: - TypeElement
public struct TypeElement: Codable {
    public let slot: Int
    public let type: Species

    public init(slot: Int, type: Species) {
        self.slot = slot
        self.type = type
    }
}
