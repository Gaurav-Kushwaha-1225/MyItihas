class SacredPlace {
  final String id;
  final String name;
  final double lat;
  final double lon;
  final String ref;
  final String description;

  const SacredPlace({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.ref,
    required this.description,
  });
}

const List<SacredPlace> sacredPlacesData = [
  // --- MAJOR SCRIPTURAL CITIES ---
  SacredPlace(
    id: 'ayodhya',
    name: 'Ayodhya',
    lat: 26.595,
    lon: 80.904,
    ref: 'Ramayana, Atharvaveda, Puranas',
    description:
        'Revered as the birthplace of Lord Rama, the seventh avatar of Vishnu, Ayodhya is one of the seven most sacred cities (Saptapuri) in Hinduism. The Ramayana describes it as the divine, prosperous capital of the Kosala Kingdom.',
  ),
  SacredPlace(
    id: 'mathura',
    name: 'Mathura',
    lat: 27.292,
    lon: 76.374,
    ref: 'Bhagavata Purana, Mahabharata, Harivamsa',
    description:
        'The sacred birthplace of Lord Krishna. The Bhagavata Purana vividly details Krishna\'s birth in a prison cell and his divine childhood in the surrounding Braj region.',
  ),
  SacredPlace(
    id: 'kurukshetra',
    name: 'Kurukshetra',
    lat: 29.869,
    lon: 75.478,
    ref: 'Mahabharata, Bhagavad Gita, Puranas',
    description:
        'The hallowed ground where the epic 18-day Kurukshetra War was fought and where Lord Krishna delivered the celestial sermon of the Bhagavad Gita to Arjuna.',
  ),
  SacredPlace(
    id: 'dwarka',
    name: 'Dwarka',
    lat: 22.041,
    lon: 67.968,
    ref: 'Mahabharata, Skanda Purana, Harivamsa',
    description:
        'An ancient, magnificent city founded by Lord Krishna on the western coast. Believed to have been submerged by the sea following Krishna\'s departure from the mortal world.',
  ),
  SacredPlace(
    id: 'hastinapur',
    name: 'Hastinapur',
    lat: 28.960,
    lon: 76.716,
    ref: 'Mahabharata, Puranas',
    description:
        'The grand capital of the Kuru Kingdom and the political epicenter of the Mahabharata. It was the coveted prize for which the great war was fought.',
  ),
  SacredPlace(
    id: 'varanasi',
    name: 'Kashi (Varanasi)',
    lat: 25.117,
    lon: 81.673,
    ref: 'Skanda Purana, Shiva Purana, Upanishads',
    description:
        'The spiritual capital of Bharat. According to the Shiva Purana, the city was founded by Lord Shiva himself and is regarded as the city of liberation (moksha).',
  ),
  SacredPlace(
    id: 'prayagraj',
    name: 'Prayagraj',
    lat: 25.235,
    lon: 80.546,
    ref: 'Ramayana, Puranas, Mahabharata',
    description:
        'Hailed as "Tirtharaj," located at the sacred confluence (Triveni Sangam) of the rivers Ganga, Yamuna, and the mythical Saraswati.',
  ),
  SacredPlace(
    id: 'ujjain',
    name: 'Ujjain',
    lat: 22.979,
    lon: 74.485,
    ref: 'Puranas, Mahabharata, Skanda Purana',
    description:
        'Home to the Mahakaleshwar Jyotirlinga. It served as the prime meridian for ancient Hindu astronomers and is one of the four sacred sites of the Kumbh Mela.',
  ),
  SacredPlace(
    id: 'rameswaram',
    name: 'Rameswaram',
    lat: 9.088,
    lon: 78.013,
    ref: 'Ramayana (Lanka Kanda), Skanda Purana',
    description:
        'From this coast, Lord Rama built the Rama Setu bridge to Lanka. He consecrated a lingam here to worship Lord Shiva before the great battle.',
  ),
  SacredPlace(
    id: 'lanka',
    name: 'Lanka',
    lat: 7.573,
    lon: 79.472,
    ref: 'Ramayana (Sundara & Yuddha Kanda)',
    description:
        'The magnificent island fortress-kingdom of Ravana. Situated atop Trikuta mountain, it was the final battlefield where Rama defeated Ravana to uphold dharma.',
  ),

  // --- HIMALAYAN & NORTHERN SITES ---
  SacredPlace(
    id: 'kedarnath',
    name: 'Kedarnath',
    lat: 30.435,
    lon: 77.567,
    ref: 'Mahabharata, Skanda Purana',
    description:
        'Nestled in the Himalayas, one of the most revered Jyotirlingas. Established by the Pandavas to atone for their sins after the Kurukshetra war.',
  ),
  SacredPlace(
    id: 'badrinath',
    name: 'Badrinath',
    lat: 30.543,
    lon: 77.993,
    ref: 'Bhagavata Purana, Vishnu Purana',
    description:
        'A Char Dham site dedicated to Lord Vishnu, who performed intense meditation here while Goddess Lakshmi sheltered him as a Badri tree.',
  ),
  SacredPlace(
    id: 'haridwar',
    name: 'Haridwar',
    lat: 29.645,
    lon: 76.764,
    ref: 'Puranas, Mahabharata',
    description:
        'Meaning "Gateway to God," where the Ganges leaves the mountains. The sacred ghat of Har Ki Pauri is the center of pilgrimage.',
  ),
  SacredPlace(
    id: 'rishikesh',
    name: 'Rishikesh',
    lat: 29.786,
    lon: 76.867,
    ref: 'Ramayana, Skanda Purana',
    description:
        'The Yoga Capital. In the Ramayana, Lord Rama and his brothers performed penance here after the war in Lanka.',
  ),
  SacredPlace(
    id: 'gangotri',
    name: 'Gangotri',
    lat: 30.694,
    lon: 77.539,
    ref: 'Puranas, Ramayana, Mahabharata',
    description:
        'The spiritual source of the River Ganga. King Bhagiratha performed penance here to bring the celestial river to Earth.',
  ),
  SacredPlace(
    id: 'yamunotri',
    name: 'Yamunotri',
    lat: 30.713,
    lon: 77.055,
    ref: 'Puranas, Mahabharata',
    description:
        'Source of the Yamuna River. Bathing in her waters is believed to absolve one from the fear of untimely death.',
  ),
  SacredPlace(
    id: 'vaishnodevi',
    name: 'Vaishno Devi',
    lat: 32.993,
    lon: 74.935,
    ref: 'Devi Bhagavata Purana, Puranas',
    description:
        'Major Shakti Peeth dedicated to Goddess Vaishnavi in the Trikuta Mountains. The Goddess manifested here as three rock heads (Pindies).',
  ),
  SacredPlace(
    id: 'amarnath',
    name: 'Amarnath Cave',
    lat: 34.215,
    lon: 75.504,
    ref: 'Mahabharata, Rajatarangini',
    description:
        'Sacred shrine where Lord Shiva revealed the secret of immortality to Parvati. Worshipped as a naturally occurring ice lingam.',
  ),

  // --- CENTRAL & SOUTHERN SITES ---
  SacredPlace(
    id: 'nashik',
    name: 'Nashik (Panchavati)',
    lat: 19.811,
    lon: 72.490,
    ref: 'Ramayana (Aranya Kanda)',
    description:
        'Where Rama, Sita, and Lakshmana spent a significant part of their exile and where the abduction of Sita took place.',
  ),
  SacredPlace(
    id: 'hampi',
    name: 'Hampi (Kishkindha)',
    lat: 15.135,
    lon: 75.160,
    ref: 'Ramayana (Kishkindha Kanda)',
    description:
        'The Vanara kingdom of Kishkindha where Rama met Hanuman and allied with the Vanara king Sugriva.',
  ),
  SacredPlace(
    id: 'tirupati',
    name: 'Tirupati',
    lat: 13.428,
    lon: 78.119,
    ref: 'Varaha Purana, Bhavishyottara Purana',
    description:
        'Famous for the Tirumala Venkateswara Temple. Lord Venkateswara manifested here to guide humanity in the Kali Yuga.',
  ),
  SacredPlace(
    id: 'madurai',
    name: 'Madurai',
    lat: 9.725,
    lon: 76.819,
    ref: 'Puranas, Sangam Literature',
    description:
        'Home to the magnificent Meenakshi Amman Temple. An ancient center of Tamil culture and learning for over two millennia.',
  ),
  SacredPlace(
    id: 'kanyakumari',
    name: 'Kanyakumari',
    lat: 7.888,
    lon: 76.238,
    ref: 'Mahabharata, Puranas',
    description:
        'The southernmost tip where three oceans meet. Dedicated to the virgin goddess Kanya Kumari, an incarnation of Parvati.',
  ),

  // --- EASTERN & WESTERN SITES ---
  SacredPlace(
    id: 'puri',
    name: 'Puri (Jagannath)',
    lat: 19.513,
    lon: 84.531,
    ref: 'Skanda Purana, Brahma Purana',
    description:
        'A Char Dham site famous for the Jagannath Temple and the annual Rath Yatra (Chariot Festival).',
  ),
  SacredPlace(
    id: 'somnath',
    name: 'Somnath',
    lat: 20.788,
    lon: 69.301,
    ref: 'Shiva Purana, Skanda Purana, Rigveda',
    description:
        'The first of the twelve Jyotirlingas. Worshipped by Chandra (the Moon God) to be freed from a curse.',
  ),
  SacredPlace(
    id: 'takshashila',
    name: 'Takshashila (Taxila)',
    lat: 33.549,
    lon: 71.489,
    ref: 'Mahabharata, Ramayana',
    description:
        'An ancient center of learning. The Mahabharata was recited here for the first time by Vaishampayana.',
  ),

  // --- THE 18 ASHTADASHA SHAKTIPEETHAS ---
  SacredPlace(
    id: 'trincomalee',
    name: 'Sankari Devi (Trincomalee)',
    lat: 8.369,
    lon: 79.933,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s thigh fell. A powerful center of divine feminine energy in Sri Lanka.',
  ),
  SacredPlace(
    id: 'kanchi-shakti',
    name: 'Kamakshi Devi (Kanchi)',
    lat: 12.436,
    lon: 78.104,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s skeleton fell. Known as the seat of learning and wisdom.',
  ),
  SacredPlace(
    id: 'praddyumnam',
    name: 'Shrunkala Devi (Praddyumnam)',
    lat: 22.369,
    lon: 87.069,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s stomach fell. Known for powerful healing and health-bestowing energies.',
  ),
  SacredPlace(
    id: 'mysore',
    name: 'Chamundeshwari Devi (Mysore)',
    lat: 12.095,
    lon: 76.239,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s hair fell. Believed to grant victory over enemies and obstacles.',
  ),
  SacredPlace(
    id: 'alampur',
    name: 'Jogulamba Devi (Alampur)',
    lat: 15.670,
    lon: 77.730,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s upper teeth fell. Known for unique architecture and wisdom-granting vibrations.',
  ),
  SacredPlace(
    id: 'srisailam-shakti',
    name: 'Bhramaramba Devi (Srisailam)',
    lat: 15.874,
    lon: 78.468,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s neck fell. Part of the famous Srisailam temple complex.',
  ),
  SacredPlace(
    id: 'kolhapur',
    name: 'Mahalakshmi Devi (Kolhapur)',
    lat: 16.504,
    lon: 73.843,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s left eye fell. Renowned for wealth, prosperity, and abundance.',
  ),
  SacredPlace(
    id: 'nanded',
    name: 'Ekaveenika Devi (Nanded)',
    lat: 18.938,
    lon: 77.021,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s right hand fell. Believed to grant blessings for success in all endeavors.',
  ),
  SacredPlace(
    id: 'ujjain-shakti',
    name: 'Mahakalai Devi (Ujjain)',
    lat: 22.979,
    lon: 75.386,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s upper lip fell. Associated with the Mahakaleshwar Jyotirlinga.',
  ),
  SacredPlace(
    id: 'pithapuram',
    name: 'Puruhuthika Devi (Pithapuram)',
    lat: 16.916,
    lon: 81.866,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s left hand fell. Believed to grant blessings for creativity and artistic skill.',
  ),
  SacredPlace(
    id: 'cuttack',
    name: 'Girija Devi (Cuttack)',
    lat: 20.262,
    lon: 85.483,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s navel fell. Deeply revered for health, vitality, and fertility.',
  ),
  SacredPlace(
    id: 'draksharamam',
    name: 'Manikyamba Devi (Draksharamam)',
    lat: 16.600,
    lon: 81.400,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s left cheek fell. Known for beauty, grace, and attraction.',
  ),
  SacredPlace(
    id: 'guwahati',
    name: 'Kamarupa Devi (Guwahati)',
    lat: 25.944,
    lon: 91.436,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s vulva fell. One of the most powerful centers for creation and life energy.',
  ),
  SacredPlace(
    id: 'prayaga',
    name: 'Madhaveshwari Devi (Prayaga)',
    lat: 25.235,
    lon: 81.446,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s fingers fell. Located at the holy confluence of the three rivers.',
  ),
  SacredPlace(
    id: 'jwala',
    name: 'Jwalamukhi Devi (Jwala)',
    lat: 31.680,
    lon: 76.020,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s head fell. Famous for its eternal flame that burns without fuel.',
  ),
  SacredPlace(
    id: 'gaya-shakti',
    name: 'Sarvamangala Devi (Gaya)',
    lat: 24.595,
    lon: 84.600,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s breast fell. Revered for nurturing, protection, and unconditional love.',
  ),
  SacredPlace(
    id: 'varanasi-shakti',
    name: 'Vishalakshi Devi (Varanasi)',
    lat: 25.117,
    lon: 82.573,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s wrist fell. Located in Kashi, believed to grant spiritual liberation.',
  ),
  SacredPlace(
    id: 'kashmir-shakti',
    name: 'Saraswathi Devi (Kashmir)',
    lat: 33.883,
    lon: 74.397,
    ref: 'Devi Bhagavata Purana, Kalika Purana',
    description:
        'Where Goddess Sati\'s right hand fell. Deeply associated with knowledge, learning, and wisdom.',
  ),
];
