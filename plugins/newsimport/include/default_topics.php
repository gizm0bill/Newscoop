<?php
/**
 * topics for categories
 */
$newsimport_default_cat_names = array();

// the first one item in each subarray shall be a root topic
$newsimport_default_cat_names['general'] = array(
    // do not change keys; num ids are for topic names by language
    'event' => array(1 => 'Event', 5 => 'Veranstaltung',), // the root of event topics
    'theater' => array(1 => 'Theater Event', 5 => 'Theater Veranstaltung',),
    'exhibition' => array(1 => 'Exhibition Event', 5 => 'Ausstellung Veranstaltung',),
    'party' => array(1 => 'Party Event', 5 => 'Party Veranstaltung',),
    'music' => array(1 => 'Music Event', 5 => 'Musik Veranstaltung',),
    'concert' => array(1 => 'Concert Event', 5 => 'Konzert Veranstaltung',),
    //'movie' => array(1 => 'Movie Event', 5 => 'Movie Veranstaltung',),
    'circus' => array(1 => 'Circus Event', 5 => 'Zirkus Veranstaltung'),
    'other' => array(1 => 'Other Event', 5 => 'Andere Veranstaltung'),
);

$newsimport_default_cat_names['movie'] = array(
    // do not change keys; num ids are for topic names by language
    'cinema' => array(1 => 'Cinema', 5 => 'Kino',), // the root of cinema topics
    'adventure' => array(1 => 'Adventure Movie', 5 => 'Abenteuer Film',),
    'action' => array(1 => 'Action Movie', 5 => 'Action Film',),
    'adult' => array(1 => 'Adult Movie', 5 => 'Adult Film',),
    'animation' => array(1 => 'Animation Movie', 5 => 'Animation Film',),
    'biography' => array(1 => 'Biography Movie', 5 => 'Biografie Film',),
    'crime' => array(1 => 'Crime Movie', 5 => 'Crime Film',),
    'documentary' => array(1 => 'Documentary Movie', 5 => 'Dokumentation Film',),
    'drama' => array(1 => 'Drama Movie', 5 => 'Drama Film',),
    'family' => array(1 => 'Family Movie', 5 => 'Familienfilm Film',),
    'fantasy' => array(1 => 'Fantasy Movie', 5 => 'Fantasy Film',),
    'film_noir' => array(1 => 'Film-Noir Movie', 5 => 'Film-Noir Film',),
    'history' => array(1 => 'History Movie', 5 => 'Historischer Film',),
    'horror' => array(1 => 'Horror Movie', 5 => 'Horror Film',),
    'comedy' => array(1 => 'Comedy Movie', 5 => 'Komödie Film',),
    'war' => array(1 => 'War Movie', 5 => 'Kriegsfilm Film',),
    'short' => array(1 => 'Short Movie', 5 => 'Kurzfilm Film',),
    'musical' => array(1 => 'Musical Movie', 5 => 'Musical Film',),
    'music' => array(1 => 'Music Movie', 5 => 'Musikfilm Film',),
    'mystery' => array(1 => 'Mystery Movie', 5 => 'Mystery Film',),
    'romance' => array(1 => 'Romance Movie', 5 => 'Romanze Film',),
    'sci_fi' => array(1 => 'Sci-Fi Movie', 5 => 'Sci-Fi Film',),
    'sport' => array(1 => 'Sport Movie', 5 => 'Sport Film',),
    'thriller' => array(1 => 'Thriller Movie', 5 => 'Thriller Film',),
    'western' => array(1 => 'Western Movie', 5 => 'Western Film',),
    'other' => array(1 => 'Other Movie', 5 => 'Anderer Film'),
);

$newsimport_default_cat_names['regions'] = array(
    // do not change keys; num ids are for topic names by language
    'region' => array(1 => 'Swiss Region', 5 => 'Region der Schweiz',), // the root of region topics
    'basel_region' => array(1 => 'Basel Region', 5 => 'Region Basel',),
    'basel_stadt' => array(1 => 'Basel-Stadt Canton', 5 => 'Kanton Basel-Stadt',),
    'basel_landschaft' => array(1 => 'Basel-Landschaft Canton', 5 => 'Kanton Basel-Landschaft',),
    'aargau' => array(1 => 'Aargau Canton', 5 => 'Kanton Aargau',),
    'appenzell_ausserrhoden' => array(1 => 'Appenzell Ausserrhoden Canton', 5 => 'Kanton Appenzell Ausserrhoden',),
    'appenzell_innerrhoden' => array(1 => 'Appenzell Innerrhoden Canton', 5 => 'Kanton Appenzell Innerrhoden',),
    'bern' => array(1 => 'Bern Canton', 5 => 'Kanton Bern',),
    'freiburg' => array(1 => 'Fribourg Canton', 5 => 'Kanton Freiburg',),
    'genf' => array(1 => 'Geneva Canton', 5 => 'Kanton Genf',),
    'glarus' => array(1 => 'Glarus Canton', 5 => 'Kanton Glarus',),
    'graubuenden' => array(1 => 'Graubünden Canton', 5 => 'Kanton Graubünden',),
    'jura' => array(1 => 'Jura Canton', 5 => 'Kanton Jura',),
    'luzern' => array(1 => 'Lucerne Canton', 5 => 'Kanton Luzern',),
    'neuenburg' => array(1 => 'Neuchâtel Canton', 5 => 'Kanton Neuenburg',),
    'nidwalden' => array(1 => 'Nidwalden Canton', 5 => 'Kanton Nidwalden',),
    'obwalden' => array(1 => 'Obwalden Canton', 5 => 'Kanton Obwalden',),
    'schaffhausen' => array(1 => 'Schaffhausen Canton', 5 => 'Kanton Schaffhausen',),
    'schwyz' => array(1 => 'Schwyz Canton', 5 => 'Kanton Schwyz',),
    'solothurn' => array(1 => 'Solothurn Canton', 5 => 'Kanton Solothurn',),
    'st_gallen' => array(1 => 'St. Gallen Canton', 5 => 'Kanton St. Gallen',),
    'tessin' => array(1 => 'Ticino Canton', 5 => 'Kanton Tessin',),
    'thurgau' => array(1 => 'Thurgau Canton', 5 => 'Kanton Thurgau',),
    'uri' => array(1 => 'Uri Canton', 5 => 'Kanton Uri',),
    'waadt' => array(1 => 'Vaud Canton', 5 => 'Kanton Waadt',),
    'wallis' => array(1 => 'Valais Canton', 5 => 'Kanton Wallis',),
    'zug' => array(1 => 'Zug Canton', 5 => 'Kanton Zug',),
    'zuerich' => array(1 => 'Zurich Canton', 5 => 'Kanton Zürich',),
);

$newsimport_default_cat_names['restaurant_cuisine'] = array(
    // do not change keys; num ids are for topic names by language
    'restaurant_cuisine' => array(1 => 'Restaurant Cuisine', 5 => 'Restaurant Küche',), // the root of restaurant cuisine topics
    'arabic_cuisine' => array(1 => 'Arabic Cuisine', 5 => 'Arabisch Küche',), // id 2
    'american_cuisine' => array(1 => 'American Cuisine', 5 => 'Amerikanisch Küche',), // id 3
    'italien_cuisine' => array(1 => 'Italien Cuisine', 5 => 'Italienisch Küche',), // id 4
    'spanish_cuisine' => array(1 => 'Spanish Cuisine', 5 => 'Spanisch Küche',), // id 5
    'turkish_cuisine' => array(1 => 'Turkish Cuisine', 5 => 'Türkisch Küche',), // id 6
    'asiatic_cuisine' => array(1 => 'Asiatic Cuisine', 5 => 'Asiatisch Küche',), // id 7
    'chinese_cuisine' => array(1 => 'Chinese Cuisine', 5 => 'Chinesisch Küche',), // id 8
    'fish_cuisine' => array(1 => 'Fish Cuisine', 5 => 'Fisch Küche',), // id 10
    'french_cuisine' => array(1 => 'French Cuisine', 5 => 'Französisch Küche',), // id 11
    'gourmet_cuisine' => array(1 => 'Gourmet Cuisine', 5 => 'Gourmet Küche',), // id 12
    'greek_cuisine' => array(1 => 'Greek Cuisine', 5 => 'Griechisch Küche',), // id 13
    'grills_cuisine' => array(1 => 'Grills Cuisine', 5 => 'Grilladen Küche',), // id 14
    'style_cuisine' => array(1 => 'Style Cuisine', 5 => 'Gut bürgerlich Küche',), // id 15
    'hamburger_cuisine' => array(1 => 'Hamburger Cuisine', 5 => 'Hamburger Küche',), // id 16
    'indian_cuisine' => array(1 => 'Indian Cuisine', 5 => 'Indisch Küche',), // id 17
    'indonesian_cuisine' => array(1 => 'Indonesian Cuisine', 5 => 'Indonesisch Küche',), // id 18
    'international_cuisine' => array(1 => 'International Cuisine', 5 => 'International Küche',), // id 19
    'japanese_cuisine' => array(1 => 'Japanese Cuisine', 5 => 'Japanisch Küche',), // id 21
    'creole_caribbean_cuisine' => array(1 => 'Creole (Caribbean) Cuisine', 5 => 'Kreolisch (Karibik) Küche',), // id 23
    'korean_cuisine' => array(1 => 'Korean Cuisine', 5 => 'Koreanisch Küche',), // id 24
    'malay_cuisine' => array(1 => 'Malay Cuisine', 5 => 'Malayisch Küche',), // id 25
    'mediterranean_cuisine' => array(1 => 'Mediterranean Cuisine', 5 => 'Mediterran Küche',), // id 26
    'mexican_cuisine' => array(1 => 'Mexican Cuisine', 5 => 'Mexikanisch Küche',), // id 27
    'mongolian_cuisine' => array(1 => 'Mongolian Cuisine', 5 => 'Mongolisch Küche',), // id 28
    'oriental_cuisine' => array(1 => 'Oriental Cuisine', 5 => 'Orientalisch Küche',), // id 29
    'pizzeria_cuisine' => array(1 => 'Pizzeria Cuisine', 5 => 'Pizzeria Küche',), // id 31
    'sushi_cuisine' => array(1 => 'Sushi Cuisine', 5 => 'Sushi Küche',), // id 32
    'swiss_cuisine' => array(1 => 'Swiss Cuisine', 5 => 'Schweizerisch Küche',), // id 34
    'thai_cuisine' => array(1 => 'Thai Cuisine', 5 => 'Thailändisch Küche',), // id 35
    'vietnamese_cuisine' => array(1 => 'Vietnamese Cuisine', 5 => 'Vietnamesisch Küche',), // id 37
    'astrian_cuisine' => array(1 => 'Astrian Cuisine', 5 => 'Österreichisch Küche',), // id 38
    'exotic_cuisine' => array(1 => 'Exotic Cuisine', 5 => 'Exotisch Küche',), // id 40
    'traditional_cuisine' => array(1 => 'Traditional Cuisine', 5 => 'Traditionell Küche',), // id 41
    'moroccan_cuisine' => array(1 => 'Moroccan Cuisine', 5 => 'Marokkanisch Küche',), // id 42
    'brasserie_cuisine' => array(1 => 'Brasserie Cuisine', 5 => 'Brasserie Küche',), // id 43
    'portuguese_cuisine' => array(1 => 'Portuguese Cuisine', 5 => 'Portugiesisch Küche',), // id 44
    'walser_specialties_cuisine' => array(1 => 'Walser Specialties Cuisine', 5 => 'Walliser-Spezialitäten Küche',), // id 45
    'vegetarian_cuisine' => array(1 => 'Vegetarian Cuisine', 5 => 'Vegetarisch Küche',), // id 46
    'argentine_cuisine' => array(1 => 'Argentine Cuisine', 5 => 'Argentinisch Küche',), // id 47
    'gratin_cuisine' => array(1 => 'Gratin Cuisine', 5 => 'Gratin Küche',), // id 48
    'cold_and_hot_sandwiches_cuisine' => array(1 => 'Cold and Hot Sandwiches Cuisine', 5 => 'Cold and Hot Sandwiches Küche',), // id 49
    'pies_and_biscuits_cuisine' => array(1 => 'Pies and Biscuits Cuisine', 5 => 'Kuchen und Gebäck Küche',), // id 51
    'bistro_cuisine' => array(1 => 'Bistro Cuisine', 5 => 'Bistroküche Küche',), // id 52
    'balkan_cuisine' => array(1 => 'Balkan Cuisine', 5 => 'Balkan Küche',), // id 53
    'seasonal_cuisine' => array(1 => 'Seasonal Cuisine', 5 => 'Saisonal Küche',), // id 54
    'steakhouse_cuisine' => array(1 => 'Steakhouse Cuisine', 5 => 'Steakhouse Küche',), // id 55
    'caribbean_cuisine' => array(1 => 'Caribbean Cuisine', 5 => 'Karibisch Küche',), // id 57
    'steak_cuisine' => array(1 => 'Steak Cuisine', 5 => 'Steak Küche',), // id 58
    'classic_cuisine' => array(1 => 'Classic Cuisine', 5 => 'Klassiker Küche',), // id 59
    'ottoman_cuisine' => array(1 => 'Ottoman Cuisine', 5 => 'Osmanisch Küche',), // id 60
    'modern_cuisine' => array(1 => 'Modern Cuisine', 5 => 'Modern Küche',), // id 61
    'fusion_cuisine' => array(1 => 'Fusion Cuisine', 5 => 'Fusion Küche',), // id 62
    'american_restaurant_cuisine' => array(1 => 'American Restaurant Cuisine', 5 => 'American Restaurant Küche',), // id 63
    'caribbean_bar_cuisine' => array(1 => 'Caribbean Bar Cuisine', 5 => 'Caribbean Bar Küche',), // id 64
    'tex_mex_cuisine' => array(1 => 'Tex-Mex Cuisine', 5 => 'Tex-Mex Küche',), // id 65
    'rustic_cuisine' => array(1 => 'Rustic Cuisine', 5 => 'Rustikal Küche',), // id 66
    'hungarian_cuisine' => array(1 => 'Hungarian Cuisine', 5 => 'Ungarisch Küche',), // id 67
    'fondue_cuisine' => array(1 => 'Fondue Cuisine', 5 => 'Fondue Küche',), // id 68
    'bavarian_cuisine' => array(1 => 'Bavarian Cuisine', 5 => 'Bayerisch Küche',), // id 69
    'regional_cuisine' => array(1 => 'Regional Cuisine', 5 => 'Regional Küche',), // id 70
    'snacks_cuisine' => array(1 => 'Snacks Cuisine', 5 => 'Snacks Küche',), // id 71
    'lebanese_cuisine' => array(1 => 'Lebanese Cuisine', 5 => 'Libanesisch Küche',), // id 72
);

$newsimport_default_cat_names['restaurant_ambiance'] = array(
    // do not change keys; num ids are for topic names by language
    'restaurant_ambiance' => array(1 => 'Restaurant Ambiance', 5 => 'Restaurant Ambiente',), // the root of restaurant ambiance topics
    'business_ambiance' => array(1 => 'Business Ambiance', 5 => 'Business Ambiente',), // id 1
    'elegant_ambiance' => array(1 => 'Elegant Ambiance', 5 => 'Elegant Ambiente',), // id 2
    'festive_ambiance' => array(1 => 'Festive Ambiance', 5 => 'Festlich Ambiente',), // id 3
    'gourmet_ambiance' => array(1 => 'Gourmet Ambiance', 5 => 'Gourmet Ambiente',), // id 5
    'classical_ambiance' => array(1 => 'Classical Ambiance', 5 => 'Klassisch Ambiente',), // id 6
    'modern_ambiance' => array(1 => 'Modern Ambiance', 5 => 'Modern Ambiente',), // id 7
    'romantic_ambiance' => array(1 => 'Romantic Ambiance', 5 => 'Romantisch Ambiente',), // id 8
    'trendy_ambiance' => array(1 => 'Trendy Ambiance', 5 => 'Trendy Ambiente',), // id 9
    'oriental_ambiance' => array(1 => 'Oriental Ambiance', 5 => 'Orientalisch Ambiente',), // id 10
    'local_style_ambiance' => array(1 => 'Local Style Ambiance', 5 => 'Landestypisch Ambiente',), // id 11
    'rustic_ambiance' => array(1 => 'Rustic Ambiance', 5 => 'Rustikal Ambiente',), // id 12
    'american_restaurant_ambiance' => array(1 => 'American Restaurant Ambiance', 5 => 'American Restaurant Ambiente',), // id 13
    'south_of_the_border_ambiance' => array(1 => 'South of the Border Ambiance', 5 => 'South of the Border Ambiente',), // id 14
);


