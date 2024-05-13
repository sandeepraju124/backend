// import 'package:flutter/material.dart';

// List<String> Restaurants = [
//   'Outdoor seating',
//   'WiFi',
//   'Parking availability',
//   'Takeout',
//   'Delivery',
//   'Reservations',
//   'Accepted Cards',
//   'Alcohol served',
//   'Vegan options',
//   'Gluten-free options',
//   'Kids menu',
//   'Live music',
//   'TV screens',
//   'Wheelchair accessible',
//   'Pet-friendly'
//   // Add more amenities as needed...
// ];

// List<String> Hotels_Accommodations = [
//   'Free breakfast',
//   'Pool',
//   'Gym',
//   'Spa',
//   'Room service',
//   'Reservations',
//   'Free WiFi',
//   'Alcohol served',
//   'Parking',
//   'Laundry service',
//   'Business center',
//   'Wheelchair accessible',
//   'Pet-friendly',
//   'Conference facilities'
//   // Add more amenities as needed...
// ];

// List<String> Spas_Salons = [
//   "Massage",
//   "Facials",
//   "Manicure/Pedicure",
//   "Haircut/Styling",
//   "Waxing",
//   "Sauna",
//   "Jacuzzi",
//   "Couples treatments",
//   "Group bookings",
//   "Organic/natural products",
//   "Wheelchair accessible"
// ];

// List<String> Fitness_Centers_Gyms = [
//   "Cardio machines",
//   "Weightlifting equipment",
//   "Personal training",
//   "Group classes (e.g., yoga, Pilates)",
//   "Sauna/Steam room",
//   "Locker rooms",
//   "Showers",
//   "Towel service",
//   "Water fountain",
//   "Accessibility equipment"
// ];

// List<String> Entertainment_Venues = [
//   "Ticket booking",
//   "Seating options (e.g., VIP, general)",
//   "Bar service",
//   "Snack bar",
//   "Wheelchair accessible",
//   "Age restrictions (if applicable)"
// ];

// List<String> Retail_Stores = [
//   "Online shopping",
//   "In-store pickup",
//   "Returns policy",
//   "Gift wrapping",
//   "Loyalty program",
//   "Personal shopping services",
//   "Alterations",
//   "Fitting rooms",
//   "Accessibility for wheelchairs/strollers"
// ];

// List<String> Healthcare_Services = [
//   "Appointment scheduling",
//   "Walk-in availability",
//   "Specialist services (e.g., cardiology, dermatology)",
//   "Diagnostic services (e.g., X-ray, ultrasound)",
//   "Telemedicine options",
//   "Insurance accepted",
//   "Pharmacy services",
//   "Wheelchair accessibility"
// ];

// List<String> Educational_Institutions = [
//   "Class schedules",
//   "Extracurricular activities",
//   "Library facilities",
//   "Sports facilities",
//   "Counseling services",
//   "Career services",
//   "Disability support services"
// ];

// List<String> Auto_Services = [
//   "Car wash",
//   "Oil change",
//   "Tire rotation",
//   "Brake service",
//   "Engine diagnostics",
//   "Shuttle service",
//   "Loaner vehicles",
//   "WiFi in waiting area"
// ];

// List<String> Financial_Services = [
//   "ATM availability",
//   "Online banking",
//   "Mobile app",
//   "Investment services",
//   "Retirement planning",
//   "Mortgage services",
//   "Insurance services",
//   "Financial advisory services"
// ];

Map<String, List<String>> subOptions = {
  'Accepted Cards': ['Credit', 'Debit', 'Cash', 'Mobile Payment'],
  'Parking availability': [
    'On-site Parking',
    'Street Parking',
    'Valet Parking'
  ],
  'Takeout': ['Yes', 'No'],
  'Delivery': ['Yes', 'No', 'Third-party Delivery'],
  'Reservations': ['Yes', 'No', 'Online Reservations'],
  'Outdoor seating': ['Patio', 'Deck', 'Garden'],
  'WiFi': ['Free', 'Paid', 'Limited'],
  'Wheelchair accessible': ['Yes', 'No'],
  'Alcohol': ['Full Bar', 'Beer and Wine Only', 'No Alcohol'],
  'Pets allowed': ['Yes', 'No', 'Service Animals Only'],
  'Smoking policy': ['Smoking Allowed', 'Non-Smoking'],
  'Live music': ['Yes', 'No', 'Occasional'],
  'Kid-friendly': ['Yes', 'No', 'Kids Menu Available'],
  'Vegetarian options': ['Yes', 'No', 'Vegan Options Available'],
  'Gluten-free options': ['Yes', 'No'],
  'Happy Hour': ['Yes', 'No', 'Weekdays Only'],
  'Outdoor games': ['Cornhole', 'Bocce Ball', 'Outdoor Chess'],
  // Add even more amenities with sub-options as needed
};

class AmenityList {
  static List<String> getAmenitiesByCategory(String category) {
    switch (category) {
      case "Restaurants":
        return [
          'Outdoor seating',
          'WiFi',
          'Parking availability',
          'Takeout',
          'Delivery',
          'Reservations',
          'Accepted Cards',
          'Alcohol served',
          'Vegan options',
          'Gluten-free options',
          'Kids menu',
          'Live music',
          'TV screens',
          'Wheelchair accessible',
          'Pet-friendly'
        ];
      case "Hotels_Accommodations":
        return [
          'Free breakfast',
          'Pool',
          'Gym',
          'Spa',
          'Room service',
          'Reservations',
          'Free WiFi',
          'Alcohol served',
          'Parking',
          'Laundry service',
          'Business center',
          'Wheelchair accessible',
          'Pet-friendly',
          'Conference facilities'
        ];
      case "Spas/Salons":
        return [
          "Massage",
          "Facials",
          "Manicure/Pedicure",
          "Haircut/Styling",
          "Waxing",
          "Sauna",
          "Jacuzzi",
          "Couples treatments",
          "Group bookings",
          "Organic/natural products",
          "Wheelchair accessible"
        ];
      case "Fitness Centers/Gyms":
        return [
          "Cardio machines",
          "Weightlifting equipment",
          "Personal training",
          "Group classes (e.g., yoga, Pilates)",
          "Sauna/Steam room",
          "Locker rooms",
          "Showers",
          "Towel service",
          "Water fountain",
          "Accessibility equipment"
        ];
      case "Entertainment_Venues":
        return [
          "Ticket booking",
          "Seating options (e.g., VIP, general)",
          "Bar service",
          "Snack bar",
          "Wheelchair accessible",
          "Age restrictions (if applicable)"
        ];
      case "Retail_Stores":
        return [
          "Online shopping",
          "In-store pickup",
          "Returns policy",
          "Gift wrapping",
          "Loyalty program",
          "Personal shopping services",
          "Alterations",
          "Fitting rooms",
          "Accessibility for wheelchairs/strollers"
        ];
      case "Healthcare_Services":
        return [
          "Appointment scheduling",
          "Walk-in availability",
          "Specialist services (e.g., cardiology, dermatology)",
          "Diagnostic services (e.g., X-ray, ultrasound)",
          "Telemedicine options",
          "Insurance accepted",
          "Pharmacy services",
          "Wheelchair accessibility"
        ];
      case "Educational_Institutions":
        return [
          "Class schedules",
          "Extracurricular activities",
          "Library facilities",
          "Sports facilities",
          "Counseling services",
          "Career services",
          "Disability support services"
        ];
      case "Auto_Services":
        return [
          "Car wash",
          "Oil change",
          "Tire rotation",
          "Brake service",
          "Engine diagnostics",
          "Shuttle service",
          "Loaner vehicles",
          "WiFi in waiting area"
        ];
      case "Financial_Services":
        return [
          "ATM availability",
          "Online banking",
          "Mobile app",
          "Investment services",
          "Retirement planning",
          "Mortgage services",
          "Insurance services",
          "Financial advisory services"
        ];
      case "Plumbers":
        return [
          "24/7 emergency service",
          "Leak detection",
          "Pipe repair",
          "Drain cleaning",
          "Water heater repair/installation",
          "Fixture installation (e.g., faucets, toilets)",
          "Sewer line repair",
          "Garbage disposal repair/installation",
          "Water filtration system installation",
          "Bathroom/kitchen remodeling",
          "Backflow prevention",
          "Gas line repair/installation",
          "Hydro-jetting services",
          "Septic tank maintenance/repair",
          "Water pressure regulation",
          "Video camera inspection",
          "Free estimates",
          "Senior citizen discounts",
          "Military discounts"
        ];

      default:
        return [
          "24/7 availability",
          "Free estimates",
          "Online booking",
          "Professional staff",
          "Quality service guarantee",
          "Emergency service",
          "Licensed and insured",
          "Customer satisfaction guarantee",
          "Transparent pricing",
          "Flexible payment options",
          "Fast response time",
          "Wide service area coverage",
          "Experienced technicians",
          "Environmentally friendly practices",
          "Safety protocols",
          "Customizable service packages",
          "Personalized customer care",
          "Senior citizen discounts",
          "Military discounts"
        ];
    }
  }
}
