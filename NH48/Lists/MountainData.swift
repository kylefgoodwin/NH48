//
//  MountainData.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//

let sampleMountains: [Mountain] = [
    // MARK: - Carter-Moriah Range
    Mountain(name: "Mount Moriah", elevation: 4049, location: "Carter-Moriah Range", description: "Ledgy summit with views of the Presidentials and the Mahoosucs.", latitude: 44.3403, longitude: -71.1321, isCompleted: false, image: "moriah"),
    Mountain(name: "Middle Carter Mountain", elevation: 4610, location: "Carter-Moriah Range", description: "Wooded peak, often hiked in conjunction with North or South Carter.", latitude: 44.3031, longitude: -71.1678, isCompleted: false, image: "middle_carter"),
    Mountain(name: "South Carter Mountain", elevation: 4420, location: "Carter-Moriah Range", description: "Located on the ridge between Middle Carter and Carter Dome.", latitude: 44.2896, longitude: -71.1763, isCompleted: false, image: "south_carter"),
    Mountain(name: "Carter Dome", elevation: 4832, location: "Carter-Moriah Range", description: "The highest peak in the Carter-Moriah Range.", latitude: 44.2678, longitude: -71.1793, isCompleted: false, image: "carter_dome"),
    Mountain(name: "Wildcat Mountain, A Peak", elevation: 4422, location: "Carter-Moriah Range", description: "Offers stunning views of Carter Notch and the Presidentials.", latitude: 44.2589, longitude: -71.2017, isCompleted: false, image: "wildcat_a"),
    Mountain(name: "Wildcat Mountain, D Peak", elevation: 4070, location: "Carter-Moriah Range", description: "Home to the Wildcat Ski Area summit lift.", latitude: 44.2641, longitude: -71.2330, isCompleted: false, image: "wildcat_d"),

    // MARK: - Franconia Range
    Mountain(name: "Mount Flume", elevation: 4328, location: "Franconia Range", description: "Steep wooded trails lead to open ledges with great views.", latitude: 44.1102, longitude: -71.6288, isCompleted: false, image: "flume"),
    Mountain(name: "Mount Garfield", elevation: 4500, location: "Franconia Range", description: "Features an old fire tower foundation and 360-degree views.", latitude: 44.1873, longitude: -71.6110, isCompleted: false, image: "garfield"),
    Mountain(name: "Mount Lafayette", elevation: 5249, location: "Franconia Range", description: "Highest peak in the Franconia Range, famous for its ridge walk.", latitude: 44.1607, longitude: -71.6445, isCompleted: false, image: "lafayette"),
    Mountain(name: "Mount Liberty", elevation: 4459, location: "Franconia Range", description: "Sharp, rocky peak offering excellent views of the notch.", latitude: 44.1159, longitude: -71.6433, isCompleted: false, image: "liberty"),
    Mountain(name: "Mount Lincoln", elevation: 5089, location: "Franconia Range", description: "Rugged peak located between Lafayette and Little Haystack.", latitude: 44.1487, longitude: -71.6447, isCompleted: false, image: "lincoln"),

    // MARK: - Kinsman Range
    Mountain(name: "Cannon Mountain", elevation: 4100, location: "Kinsman Range", description: "Accessible by tramway; features an observation tower.", latitude: 44.1568, longitude: -71.6987, isCompleted: false, image: "cannon"),
    Mountain(name: "North Kinsman", elevation: 4293, location: "Kinsman Range", description: "Offers a spectacular view of Franconia Ridge from a ledge.", latitude: 44.1334, longitude: -71.7368, isCompleted: false, image: "north_kinsman"),
    Mountain(name: "South Kinsman", elevation: 4358, location: "Kinsman Range", description: "The higher of the two Kinsmans, with a wide, flat summit.", latitude: 44.1230, longitude: -71.7397, isCompleted: false, image: "south_kinsman"),

    // MARK: - Moosilauke Range
    Mountain(name: "Mount Moosilauke", elevation: 4802, location: "Moosilauke Range", description: "The westernmost 4000-footer, known for its gentle carriage road.", latitude: 44.0245, longitude: -71.8309, isCompleted: false, image: "moosilauke"),

    // MARK: - Pemigewasset Wilderness
    Mountain(name: "Owl's Head", elevation: 4025, location: "Pemigewasset Wilderness", description: "Remote peak located in the heart of the Pemi Wilderness.", latitude: 44.1444, longitude: -71.6049, isCompleted: false, image: "owls_head"),
    Mountain(name: "Mount Carrigain", elevation: 4700, location: "Pemigewasset Wilderness", description: "Features a fire tower with commanding views of the White Mountains.", latitude: 44.0938, longitude: -71.4589, isCompleted: false, image: "carrigain"),
    Mountain(name: "Mount Hancock", elevation: 4420, location: "Pemigewasset Wilderness", description: "Wooded summit near the hairpin turn of the Kancamagus Highway.", latitude: 44.0835, longitude: -71.4939, isCompleted: false, image: "hancock"),
    Mountain(name: "South Hancock", elevation: 4319, location: "Pemigewasset Wilderness", description: "Often hiked with Mount Hancock via a loop trail.", latitude: 44.0739, longitude: -71.4883, isCompleted: false, image: "south_hancock"),

    // MARK: - Pilot Range
    Mountain(name: "Mount Cabot", elevation: 4170, location: "Pilot Range", description: "The northernmost 4000-footer, located in the Kilkenny region.", latitude: 44.5061, longitude: -71.4144, isCompleted: false, image: "cabot"),

    // MARK: - Pliny Range
    Mountain(name: "Mount Waumbek", elevation: 4006, location: "Pliny Range", description: "Wooded peak with limited views, often hiked in winter.", latitude: 44.4354, longitude: -71.4173, isCompleted: false, image: "waumbek"),

    // MARK: - Presidential Range
    Mountain(name: "Mount Adams", elevation: 5774, location: "Presidential Range", description: "Second highest peak in NE, known for its complex trail network.", latitude: 44.3206, longitude: -71.2913, isCompleted: false, image: "adams"),
    Mountain(name: "Mount Eisenhower", elevation: 4780, location: "Presidential Range", description: "Famous for its bald, round summit dome.", latitude: 44.2405, longitude: -71.3503, isCompleted: false, image: "eisenhower"),
    Mountain(name: "Mount Isolation", elevation: 4003, location: "Presidential Range", description: "Remote peak requiring a long approach, great views of Washington.", latitude: 44.2147, longitude: -71.3094, isCompleted: false, image: "isolation"),
    Mountain(name: "Mount Jackson", elevation: 4052, location: "Presidential Range", description: "Features a rocky summit cone and views of Crawford Notch.", latitude: 44.2031, longitude: -71.3753, isCompleted: false, image: "jackson"),
    Mountain(name: "Mount Jefferson", elevation: 5712, location: "Presidential Range", description: "Third highest peak, with a rugged Castellated Ridge.", latitude: 44.3042, longitude: -71.3013, isCompleted: false, image: "jefferson"),
    Mountain(name: "Mount Madison", elevation: 5367, location: "Presidential Range", description: "Northernmost Presidential peak, site of the Madison Spring Hut.", latitude: 44.3283, longitude: -71.2777, isCompleted: false, image: "madison"),
    Mountain(name: "Mount Monroe", elevation: 5384, location: "Presidential Range", description: "Secondary peak near Lakes of the Clouds, with two summits.", latitude: 44.2550, longitude: -71.3214, isCompleted: false, image: "monroe"),
    Mountain(name: "Mount Pierce", elevation: 4310, location: "Presidential Range", description: "Easily accessible peak, popular in winter.", latitude: 44.2265, longitude: -71.3657, isCompleted: false, image: "pierce"),
    Mountain(name: "Mount Washington", elevation: 6288, location: "Presidential Range", description: "The highest peak in the Northeast, known for the world's worst weather.", latitude: 44.2704, longitude: -71.3033, isCompleted: false, image: "washington"),

    // MARK: - Sandwich Range
    Mountain(name: "Mount Osceola", elevation: 4340, location: "Sandwich Range", description: "Rocky summit with clear views of the Tripyramids.", latitude: 44.0014, longitude: -71.5358, isCompleted: false, image: "osceola"),
    Mountain(name: "East Osceola", elevation: 4156, location: "Sandwich Range", description: "Wooded peak connected to Mt. Osceola by a steep chimney.", latitude: 44.0062, longitude: -71.5205, isCompleted: false, image: "east_osceola"),
    Mountain(name: "Mount Passaconaway", elevation: 4043, location: "Sandwich Range", description: "Named after a Penacook sachem; heavily wooded.", latitude: 43.9555, longitude: -71.3809, isCompleted: false, image: "passaconaway"),
    Mountain(name: "Mount Tecumseh", elevation: 4003, location: "Sandwich Range", description: "Home to Waterville Valley Ski Area.", latitude: 43.9666, longitude: -71.5568, isCompleted: false, image: "tecumseh"),
    Mountain(name: "Mount Tripyramid, Middle", elevation: 4140, location: "Sandwich Range", description: "Part of the Tripyramid massif, often hiked with North Peak.", latitude: 43.9567, longitude: -71.4426, isCompleted: false, image: "middle_tripyramid"),
    Mountain(name: "Mount Tripyramid, North", elevation: 4180, location: "Sandwich Range", description: "Known for its steep North Slide.", latitude: 43.9602, longitude: -71.4402, isCompleted: false, image: "north_tripyramid"),
    Mountain(name: "Mount Whiteface", elevation: 4019, location: "Sandwich Range", description: "Features steep ledges and a distinctive rocky face.", latitude: 43.9338, longitude: -71.4058, isCompleted: false, image: "whiteface"),

    // MARK: - Twin Range
    Mountain(name: "Mount Bond", elevation: 4698, location: "Twin Range", description: "Remote peak with incredible views of the Pemi Wilderness.", latitude: 44.1528, longitude: -71.5312, isCompleted: false, image: "bond"),
    Mountain(name: "Mount Bond, West Peak", elevation: 4540, location: "Twin Range", description: "Spur peak off Mount Bond, majestic deep-wilderness feel.", latitude: 44.1541, longitude: -71.5435, isCompleted: false, image: "west_bond"),
    Mountain(name: "Bondcliff", elevation: 4265, location: "Twin Range", description: "Iconic cliff-edge photo spot; very remote.", latitude: 44.1396, longitude: -71.5420, isCompleted: false, image: "bondcliff"),
    Mountain(name: "Mount Galehead", elevation: 4024, location: "Twin Range", description: "Wooded summit with a view from the nearby hut.", latitude: 44.1852, longitude: -71.5735, isCompleted: false, image: "galehead"),
    Mountain(name: "Mount Hale", elevation: 4054, location: "Twin Range", description: "Features a large cairn on a wooded summit.", latitude: 44.2217, longitude: -71.5121, isCompleted: false, image: "hale"),
    Mountain(name: "North Twin Mountain", elevation: 4761, location: "Twin Range", description: "Offers expansive views to the north and west.", latitude: 44.2025, longitude: -71.5583, isCompleted: false, image: "north_twin"),
    Mountain(name: "South Twin Mountain", elevation: 4902, location: "Twin Range", description: "Steep ascent with commanding views of the Franconia Range.", latitude: 44.1878, longitude: -71.5548, isCompleted: false, image: "south_twin"),
    Mountain(name: "Zealand Mountain", elevation: 4260, location: "Twin Range", description: "Wooded peak with a viewless summit, marked by a sign.", latitude: 44.1793, longitude: -71.5211, isCompleted: false, image: "zealand"),

    // MARK: - Willey Range
    Mountain(name: "Mount Field", elevation: 4340, location: "Willey Range", description: "Highest in the Willey Range; wooded.", latitude: 44.1963, longitude: -71.4332, isCompleted: false, image: "field"),
    Mountain(name: "Mount Tom", elevation: 4051, location: "Willey Range", description: "Nearby Mount Field, offers partial views.", latitude: 44.2104, longitude: -71.4457, isCompleted: false, image: "tom"),
    Mountain(name: "Mount Willey", elevation: 4285, location: "Willey Range", description: "Known for steep ladders on the trail and Crawford Notch views.", latitude: 44.1834, longitude: -71.4211, isCompleted: false, image: "willey")
]
