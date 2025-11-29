//
//  MountainData.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//

let sampleMountains: [Mountain] = [
    // Presidential Range
    Mountain(name: "Mount Washington", elevation: 6288, location: "Presidential Range", description: "Tallest peak in the Northeast, known for extreme weather.", latitude: 44.2706, longitude: -71.3033, isCompleted: false, image: "washington"),
    Mountain(name: "Mount Adams", elevation: 5799, location: "Presidential Range", description: "Second highest peak, rugged terrain and panoramic views.", latitude: 44.3207, longitude: -71.3040, isCompleted: false, image: "adams"),
    Mountain(name: "Mount Jefferson", elevation: 5712, location: "Presidential Range", description: "Rocky ridges and steep trails, part of the Presidential Traverse.", latitude: 44.3242, longitude: -71.3037, isCompleted: false),
    Mountain(name: "Mount Monroe", elevation: 5372, location: "Presidential Range", description: "Alpine tundra environment near Lakes of the Clouds Hut.", latitude: 44.2742, longitude: -71.3033, isCompleted: false),
    Mountain(name: "Mount Eisenhower", elevation: 4780, location: "Presidential Range", description: "Named for President Eisenhower, features rocky summit.", latitude: 44.2696, longitude: -71.3042, isCompleted: false),
    Mountain(name: "Mount Pierce", elevation: 4310, location: "Presidential Range", description: "Open ledges and mixed forests, popular hiking destination.", latitude: 44.2529, longitude: -71.3031, isCompleted: false),
    Mountain(name: "Mount Jackson", elevation: 4052, location: "Presidential Range", description: "Wooded trails with occasional rocky ledges.", latitude: 44.2528, longitude: -71.3155, isCompleted: false),
    Mountain(name: "Mount Isolation", elevation: 4003, location: "Presidential Range", description: "Remote and quiet peak, prized for solitude.", latitude: 44.2547, longitude: -71.3379, isCompleted: false),
    
    // Franconia Range
    Mountain(name: "Mount Lafayette", elevation: 5260, location: "Franconia Range", description: "Highest peak in the Franconia Range, with breathtaking cliff views.", latitude: 44.2672, longitude: -71.3033, isCompleted: false),
    Mountain(name: "Mount Lincoln", elevation: 5089, location: "Franconia Range", description: "Offers spectacular ridge views and alpine scenery.", latitude: 44.2580, longitude: -71.3168, isCompleted: false),
    Mountain(name: "Little Haystack Mountain", elevation: 4780, location: "Franconia Range", description: "Smaller peak with great views, part of the Franconia Ridge Trail.", latitude: 44.2521, longitude: -71.3219, isCompleted: false),
    Mountain(name: "Mount Liberty", elevation: 4459, location: "Franconia Range", description: "Popular peak with stunning vistas of the surrounding area.", latitude: 44.2379, longitude: -71.3234, isCompleted: false),
    Mountain(name: "Mount Flume", elevation: 4328, location: "Franconia Range", description: "Steep wooded trails lead to open ledges.", latitude: 44.2207, longitude: -71.3276, isCompleted: false),
    Mountain(name: "Mount Garfield", elevation: 4500, location: "Franconia Range", description: "Offers views of Franconia Notch and nearby peaks.", latitude: 44.2328, longitude: -71.3300, isCompleted: false),

    // Moosilauke Range
    Mountain(name: "Mount Moosilauke", elevation: 4802, location: "Moosilauke Range", description: "Large open summit with 360-degree views.", latitude: 43.9298, longitude: -71.7748, isCompleted: false),

    // Pilot Range
    Mountain(name: "Mount Cabot", elevation: 4080, location: "Pilot Range", description: "Highest peak in the Pilot Range, very remote.", latitude: 44.5872, longitude: -71.6411, isCompleted: false),

    // Carrigain Range
    Mountain(name: "Mount Carrigain", elevation: 4700, location: "Carrigain Range", description: "Striking summit with panoramic views.", latitude: 44.1131, longitude: -71.5335, isCompleted: false),

    // Bond Range
    Mountain(name: "Mount Bond", elevation: 4698, location: "Bond Range", description: "Twin peaks with rugged ridges.", latitude: 44.0878, longitude: -71.5845, isCompleted: false),
    Mountain(name: "West Bond", elevation: 4540, location: "Bond Range", description: "Challenging ridgeline hike with beautiful vistas.", latitude: 44.0861, longitude: -71.5980, isCompleted: false),
    Mountain(name: "Bondcliff", elevation: 4265, location: "Bond Range", description: "Known for dramatic cliff edge vistas.", latitude: 44.0892, longitude: -71.6192, isCompleted: false),

    // Twin Range
    Mountain(name: "South Twin Mountain", elevation: 4902, location: "Twin Range", description: "Panoramic views and challenging ridges.", latitude: 44.1133, longitude: -71.5405, isCompleted: false),
    Mountain(name: "North Twin Mountain", elevation: 4761, location: "Twin Range", description: "Wild and rugged, less crowded.", latitude: 44.1417, longitude: -71.5223, isCompleted: false),
    Mountain(name: "Mount Guyot", elevation: 4620, location: "Twin Range", description: "Least visited, peaceful and remote.", latitude: 44.1467, longitude: -71.5172, isCompleted: false),

    // Willey Range
    Mountain(name: "Mount Willey", elevation: 4222, location: "Willey Range", description: "Steep and scenic hiking trails.", latitude: 44.0895, longitude: -71.3634, isCompleted: false),
    Mountain(name: "Mount Field", elevation: 4260, location: "Willey Range", description: "Wooded hiking with rewarding summit views.", latitude: 44.0931, longitude: -71.3489, isCompleted: false),

    // Sandwich Range
    Mountain(name: "Mount Tecumseh", elevation: 4003, location: "Sandwich Range", description: "Easiest of the 4000-footers to climb.", latitude: 44.1783, longitude: -71.2855, isCompleted: false),
    Mountain(name: "Mount Waumbek", elevation: 4006, location: "Sandwich Range", description: "Northernmost 4000-footer, less crowded.", latitude: 44.6517, longitude: -71.6440, isCompleted: false),
    Mountain(name: "Mount Whiteface", elevation: 4019, location: "Sandwich Range", description: "Rocky summit with sweeping views.", latitude: 44.0528, longitude: -71.1765, isCompleted: false),
    Mountain(name: "Mount Passaconaway", elevation: 4043, location: "Sandwich Range", description: "Scenic forested trails.", latitude: 44.0806, longitude: -71.1915, isCompleted: false),
    Mountain(name: "Mount Hale", elevation: 4054, location: "Sandwich Range", description: "Open summit with views of Squam Lake.", latitude: 44.0965, longitude: -71.2060, isCompleted: false),

    // Kinsman Range
    Mountain(name: "Mount Kinsman", elevation: 4293, location: "Kinsman Range", description: "Steep trails and rewarding views.", latitude: 43.9789, longitude: -71.7655, isCompleted: false),
    Mountain(name: "North Kinsman", elevation: 4358, location: "Kinsman Range", description: "Popular peak with excellent views.", latitude: 43.9867, longitude: -71.7684, isCompleted: false),

    // Zealand Range
    Mountain(name: "Mount Zealand", elevation: 4340, location: "Zealand Range", description: "Scenic ledges and stunning views.", latitude: 44.1872, longitude: -71.5357, isCompleted: false),

    // Additional peaks to complete 48
    Mountain(name: "South Carter Mountain", elevation: 4600, location: "Carter-Moriah Range", description: "Known for rocky ridges and views.", latitude: 44.1793, longitude: -71.0807, isCompleted: false),
    Mountain(name: "Middle Carter Mountain", elevation: 4600, location: "Carter-Moriah Range", description: "Popular hiking destination with scenic views.", latitude: 44.1803, longitude: -71.0745, isCompleted: false),
    Mountain(name: "North Carter Mountain", elevation: 4600, location: "Carter-Moriah Range", description: "Rocky summit with great vistas.", latitude: 44.1833, longitude: -71.0697, isCompleted: false),
    Mountain(name: "Mount Moriah", elevation: 4600, location: "Carter-Moriah Range", description: "Known for expansive summit views.", latitude: 44.1861, longitude: -71.0639, isCompleted: false),
    Mountain(name: "Mount Field", elevation: 4260, location: "Presidential Range", description: "Wooded peak near Crawford Notch.", latitude: 44.0931, longitude: -71.3489, isCompleted: false),
    Mountain(name: "South Baldface", elevation: 3600, location: "Baldface Range", description: "Not a 4000-footer but often included in hikes.", latitude: 44.1503, longitude: -71.0910, isCompleted: false),
]
