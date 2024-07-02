// icons.dart

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

////////////// subcategory icons ///////////////

Map<String, IconData> subcategoryIconMap = {
  // 'Clothing': LineAwesomeIcons.t_shirt,
  // 'Music School': Icons.music_note_outlined,
  // 'Coffee Tea': Icons.coffee_sharp,
  // "Indian Restaurant": LineAwesomeIcons.utensils,
  // "Gym": LineAwesomeIcons.dumbbell,
  // "Restaurant": LineAwesomeIcons.utensils,
  // "Pizzeria": LineAwesomeIcons.hamburger,
  // "Bakeries": LineAwesomeIcons.birthday_cake,
  // "Housingrent": LineAwesomeIcons.city,
  // "Bookstore": LineAwesomeIcons.book,
  "Barbers": Icons.person_outline, // Icon for Barbers
  "Cosmetics & Beauty Supply":
      Icons.spa_outlined, // Icon for Cosmetics & Beauty Supply
  "Acne Treatment": Icons.healing, // Icon for Acne Treatment
  "Adult Education": Icons.school, // Icon for Adult Education
  "Plumbers": Icons.construction, // Icon for Plumbers
  "Electricians": Icons.electrical_services, // Icon for Electricians
  "Carpenters": Icons.construction, // Icon for Carpenters
  "Gardeners": Icons.local_florist, // Icon for Gardeners
  "Home Cleaning": Icons.cleaning_services, // Icon for Home Cleaning
  "Interior Design": Icons.design_services, // Icon for Interior Design
  "Mobile Home Repair": Icons.construction, // Icon for Mobile Home Repair
  "Bars": Icons.bar_chart, // Icon for Bars
  "Cocktail Bars": Icons.bar_chart, // Icon for Cocktail Bars
  "Comedy Clubs": Icons.theaters, // Icon for Comedy Clubs
  "Club Crawl": Icons.nightlife, // Icon for Club Crawl
  "Jazz & Blues": Icons.music_note, // Icon for Jazz & Blues

  // Add more mappings as needed...
};

IconData getIconForSubcategory(String subcategory) {
  // Check if the subcategory exists in the map
  if (subcategoryIconMap.containsKey(subcategory)) {
    // Return the corresponding icon
    return subcategoryIconMap[subcategory] ?? Icons.error;
  } else {
    // Return a default icon
    return Icons.error;
  }
}

////////////// category icons  /////////

// Add this mapping at the top of your icons.dart file, similar to the subcategoryIconMap
Map<String, IconData> categoryIconMap = {
  'Beauty & Spas':
      Icons.spa_outlined, // Replace with the actual icon for Category1
  'Education': Icons.school_outlined,
  'Home Services': Icons.home,
  'Nightlife': Icons.nightlife_outlined
};

// Add this function to retrieve the icon for a given category
IconData getIconForCategory(String category) {
  // Check if the category exists in the map
  if (categoryIconMap.containsKey(category)) {
    // Return the corresponding icon
    return categoryIconMap[category] ?? Icons.error;
  } else {
    // Return a default icon
    return Icons.error;
  }
}
