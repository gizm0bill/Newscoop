<?php
/**
 * event import configurations
 */
$event_data_sources = array(
    'events_1' => array(
        'admin_user_id' => 1,
        'provider_id' => 1,
        'provider_name' => 'Werbeverlags AG',
        'event_type' => 'general',
        'article_type' => 'event',
        'images_local' => true,
        'publication_id' => 0, // 2
        'issue_number' => 0, // 13,
        'section_number' => 0, // 30,
        'language_id' => 5, // 1,
        'multi_dates' => true,
        'source_dirs' => array(
            'new' => 'ftp/werbeverlags/',
            'use' => 'ftp/newsimport/events/current/',
            'old' => 'ftp/newsimport/events/processed/',
            'lock' => 'delivery.lock',
            'ready' => array(
                'events' => 'events_done.txt',
            ),
            'source' => array(
                'events' => array('events_all_*',),
            ),
        ),
        'categories' => array(
            'theater' => array('theater', 'theatre',),
            'exhibition' => array('exhibition', 'ausstellung', 'ausstellungen',), // both museums and galleries
            'party' => array('party',),
            'music' => array('music', 'musik', 'concert', 'konzerte',),
            'concert' => array('concert', 'konzerte',),
            //'circus' => array('circus', 'zirkus',),
            'other' => 'x',
        ),
        'status' => array(
            'public' => true,
            'comments' => false,
            'publish' => true,
            'publish_date_by_event_date' => true,
        ),
        'geo' => array(
            'map_provider' => 'mapquest', // googlev3, mapquest, osm
            'map_zoom' => 15,
            'map_width' => 600,
            'map_height' => 400,
            'poi_marker_name' => 'marker-gold.png',
            'poi_desc_len' => 100,
        ),
    ),
    'movies_1' => array(
        'admin_user_id' => 1,
        'provider_id' => 2,
        'provider_name' => 'Werbeverlags AG',
        'event_type' => 'movie',
        'article_type' => 'screening',
        'images_local' => true,
        'publication_id' => 0,
        'issue_number' => 0,
        'section_number' => 0,
        'language_id' => 5,
        'multi_dates' => false,
        'source_dirs' => array(
            'new' => 'ftp/werbeverlags/',
            'use' => 'ftp/newsimport/movies/current/',
            'old' => 'ftp/newsimport/movies/processed/',
            'lock' => 'delivery.lock',
            'ready' => array(
                'programs' => 'wvag_cine_done.txt',
                'movies' => 'ci_done.txt',
                'genres' => 'ci_done.txt',
                'timestamps' => 'ci_done.txt',
            ),
            'source' => array(
                'programs' => array('tageswoche_7d.xml.gz',),
                'movies' => array('tageswoche_mov_all.zip', 'tageswoche_mov.xml.gz',),
                'genres' => array('tageswoche_gen_all.zip','tageswoche_gen.xml.gz',),
                'timestamps' => array('tageswoche_tim_all.zip', 'tageswoche_tim.xml.gz',),
            ),
        ),
        'categories' => array(
            //'movie' => '*',
            'adventure' => array('adventure', 'abenteuer',),
            'action' => array('action', 'action',),
            'adult' => array('adult', 'adult',),
            'animation' => array('animation', 'animation',),
            'biography' => array('biography', 'biografie',),
            'crime' => array('crime', 'crime',),
            'documentary' => array('documentary', 'dokumentation',),
            'drama' => array('drama', 'drama',),
            'family' => array('family', 'familienfilm',),
            'fantasy' => array('fantasy', 'fantasy',),
            'film_noir' => array('film-noir', 'film-noir',),
            'history' => array('history', 'historisch',),
            'horror' => array('horror', 'horror',),
            'comedy' => array('comedy', 'komödie',),
            'war' => array('war', 'kriegsfilm',),
            'short' => array('short', 'kurzfilm',),
            'musical' => array('musical', 'musical',),
            'music' => array('music', 'musikfilm',),
            'mystery' => array('mystery', 'mystery',),
            'romance' => array('romance', 'romanze',),
            'sci_fi' => array('sci-fi', 'sci-fi',),
            'sport' => array('sport', 'sport',),
            'thriller' => array('thriller', 'thriller',),
            'western' => array('western', 'western',),
            'other' => 'x',
        ),
        'status' => array(
            'public' => true,
            'comments' => false,
            'publish' => true,
            'publish_date_by_event_date' => true,
        ),
        'geo' => array(
            'map_provider' => 'mapquest', // googlev3, mapquest, osm
            'map_zoom' => 15,
            'map_width' => 600,
            'map_height' => 400,
            'poi_marker_name' => 'marker-gold.png',
            'poi_desc_len' => 100,
        ),
    ),


    'restaurants_1' => array(
        'admin_user_id' => 1,
        'provider_id' => 5,
        'provider_name' => 'Lunchgate.ch',
        'event_type' => 'restaurant',
        'article_type' => 'restaurant',
        'images_local' => true,
        'publication_id' => 0, // 2
        'issue_number' => 0, // 13,
        'section_number' => 0, // 30,
        'language_id' => 5, // 1,
        'multi_dates' => false, // true,
        'source_dirs' => array(
            'use' => 'ftp/newsimport/restaurants/current/',
            'old' => 'ftp/newsimport/restaurants/processed/',
        ),
        'topic_types' => array(
            'restaurant_cuisine',
            'restaurant_ambiance',
        ),
        'categories' => array(
            'restaurant_ambiance' => array(
                'business_ambiance' => array('Business', 'Business',), // id 1
                'elegant_ambiance' => array('Elegant', 'Elegant',), // id 2
                'festive_ambiance' => array('Festive', 'Festlich',), // id 3
                'gourmet_ambiance' => array('Gourmet', 'Gourmet',), // id 5
                'classical_ambiance' => array('Classical', 'Klassisch',), // id 6
                'modern_ambiance' => array('Modern', 'Modern',), // id 7
                'romantic_ambiance' => array('Romantic', 'Romantisch',), // id 8
                'trendy_ambiance' => array('Trendy', 'Trendy',), // id 9
                'oriental_ambiance' => array('Oriental', 'Orientalisch',), // id 10
                'local_style_ambiance' => array('Local Style', 'Landestypisch',), // id 11
                'rustic_ambiance' => array('Rustic', 'Rustikal',), // id 12
                'american_restaurant_ambiance' => array('American Restaurant', 'American Restaurant',), // id 13
                'south_of_the_border_ambiance' => array('South of the Border', 'South of the Border',), // id 14
                'other' => 'x',
            ),
            'restaurant_cuisine' => array(
                'arabic_cuisine' => array('Arabic', 'Arabisch',), // id 2
                'american_cuisine' => array('American', 'Amerikanisch',), // id 3
                'italien_cuisine' => array('Italien', 'Italienisch',), // id 4
                'spanish_cuisine' => array('Spanish', 'Spanisch',), // id 5
                'turkish_cuisine' => array('Turkish', 'Türkisch',), // id 6
                'asiatic_cuisine' => array('Asiatic', 'Asiatisch',), // id 7
                'chinese_cuisine' => array('Chinese', 'Chinesisch',), // id 8
                'fish_cuisine' => array('Fish', 'Fisch',), // id 10
                'french_cuisine' => array('French', 'Französisch',), // id 11
                'gourmet_cuisine' => array('Gourmet', 'Gourmet',), // id 12
                'greek_cuisine' => array('Greek', 'Griechisch',), // id 13
                'grills_cuisine' => array('Grills', 'Grilladen',), // id 14
                'style_cuisine' => array('Style', 'Gut bürgerlich',), // id 15
                'hamburger_cuisine' => array('Hamburger', 'Hamburger',), // id 16
                'indian_cuisine' => array('Indian', 'Indisch',), // id 17
                'indonesian_cuisine' => array('Indonesian', 'Indonesisch',), // id 18
                'international_cuisine' => array('International', 'International',), // id 19
                'japanese_cuisine' => array('Japanese', 'Japanisch',), // id 21
                'creole_caribbean_cuisine' => array('Creole (Caribbean)', 'Kreolisch (Karibik)',), // id 23
                'korean_cuisine' => array('Korean', 'Koreanisch',), // id 24
                'malay_cuisine' => array('Malay', 'Malayisch',), // id 25
                'mediterranean_cuisine' => array('Mediterranean', 'Mediterran',), // id 26
                'mexican_cuisine' => array('Mexican', 'Mexikanisch',), // id 27
                'mongolian_cuisine' => array('Mongolian', 'Mongolisch',), // id 28
                'oriental_cuisine' => array('Oriental', 'Orientalisch',), // id 29
                'pizzeria_cuisine' => array('Pizzeria', 'Pizzeria',), // id 31
                'sushi_cuisine' => array('Sushi', 'Sushi',), // id 32
                'swiss_cuisine' => array('Swiss', 'Schweizerisch',), // id 34
                'thai_cuisine' => array('Thai', 'Thailändisch',), // id 35
                'vietnamese_cuisine' => array('Vietnamese', 'Vietnamesisch',), // id 37
                'astrian_cuisine' => array('Astrian', 'Österreichisch',), // id 38
                'exotic_cuisine' => array('Exotic', 'Exotisch',), // id 40
                'traditional_cuisine' => array('Traditional', 'Traditionell',), // id 41
                'moroccan_cuisine' => array('Moroccan', 'Marokkanisch',), // id 42
                'brasserie_cuisine' => array('Brasserie', 'Brasserie',), // id 43
                'portuguese_cuisine' => array('Portuguese', 'Portugiesisch',), // id 44
                'walser_specialties_cuisine' => array('Walser Specialties', 'Walliser-Spezialitäten',), // id 45
                'vegetarian_cuisine' => array('Vegetarian', 'Vegetarisch',), // id 46
                'argentine_cuisine' => array('Argentine', 'Argentinisch',), // id 47
                'gratin_cuisine' => array('Gratin', 'Gratin',), // id 48
                'cold_and_hot_sandwiches_cuisine' => array('Cold and Hot Sandwiches', 'Cold and Hot Sandwiches',), // id 49
                'pies_and_biscuits_cuisine' => array('Pies and Biscuits', 'Kuchen und Gebäck',), // id 51
                'bistro_cuisine' => array('Bistro', 'Bistroküche',), // id 52
                'balkan_cuisine' => array('Balkan', 'Balkan',), // id 53
                'seasonal_cuisine' => array('Seasonal', 'Saisonal',), // id 54
                'steakhouse_cuisine' => array('Steakhouse', 'Steakhouse',), // id 55
                'caribbean_cuisine' => array('Caribbean', 'Karibisch',), // id 57
                'steak_cuisine' => array('Steak', 'Steak',), // id 58
                'classic_cuisine' => array('Classic', 'Klassiker',), // id 59
                'ottoman_cuisine' => array('Ottoman', 'Osmanisch',), // id 60
                'modern_cuisine' => array('Modern', 'Modern',), // id 61
                'fusion_cuisine' => array('Fusion', 'Fusion',), // id 62
                'american_restaurant_cuisine' => array('American Restaurant', 'American Restaurant',), // id 63
                'caribbean_bar_cuisine' => array('Caribbean Bar', 'Caribbean Bar',), // id 64
                'tex_mex_cuisine' => array('Tex-Mex', 'Tex-Mex',), // id 65
                'rustic_cuisine' => array('Rustic', 'Rustikal',), // id 66
                'hungarian_cuisine' => array('Hungarian', 'Ungarisch',), // id 67
                'fondue_cuisine' => array('Fondue', 'Fondue',), // id 68
                'bavarian_cuisine' => array('Bavarian', 'Bayerisch',), // id 69
                'regional_cuisine' => array('Regional', 'Regional',), // id 70
                'snacks_cuisine' => array('Snacks', 'Snacks',), // id 71
                'lebanese_cuisine' => array('Lebanese', 'Libanesisch',), // id 72
                'other' => 'x',
            ),
        ),
        'status' => array(
            'public' => true,
            'comments' => false,
            'publish' => true,
            'publish_date_by_event_date' => false,
        ),
        'geo' => array(
            'map_provider' => 'mapquest', // googlev3, mapquest, osm
            'map_zoom' => 15,
            'map_width' => 600,
            'map_height' => 400,
            'poi_marker_name' => 'marker-gold.png',
            'poi_desc_len' => 100,
        ),
    ),

);

?>