puts "Clearing old data..."
OrderItem.destroy_all
Order.destroy_all
RoomCategory.destroy_all
Room.destroy_all
Category.destroy_all
Hotel.destroy_all
Province.destroy_all
Page.destroy_all
User.where(admin: true).destroy_all

# ── PROVINCES (all 13 with correct Canadian tax rates) ──
puts "Seeding provinces..."
Province.create!([
  { name: "Alberta",                   code: "AB", gst: 0.05,    pst: 0.0,     hst: 0.0  },
  { name: "British Columbia",          code: "BC", gst: 0.05,    pst: 0.07,    hst: 0.0  },
  { name: "Manitoba",                  code: "MB", gst: 0.05,    pst: 0.07,    hst: 0.0  },
  { name: "New Brunswick",             code: "NB", gst: 0.0,     pst: 0.0,     hst: 0.15 },
  { name: "Newfoundland and Labrador", code: "NL", gst: 0.0,     pst: 0.0,     hst: 0.15 },
  { name: "Northwest Territories",     code: "NT", gst: 0.05,    pst: 0.0,     hst: 0.0  },
  { name: "Nova Scotia",               code: "NS", gst: 0.0,     pst: 0.0,     hst: 0.15 },
  { name: "Nunavut",                   code: "NU", gst: 0.05,    pst: 0.0,     hst: 0.0  },
  { name: "Ontario",                   code: "ON", gst: 0.0,     pst: 0.0,     hst: 0.13 },
  { name: "Prince Edward Island",      code: "PE", gst: 0.0,     pst: 0.0,     hst: 0.15 },
  { name: "Quebec",                    code: "QC", gst: 0.05,    pst: 0.09975, hst: 0.0  },
  { name: "Saskatchewan",              code: "SK", gst: 0.05,    pst: 0.06,    hst: 0.0  },
  { name: "Yukon",                     code: "YT", gst: 0.05,    pst: 0.0,     hst: 0.0  },
])
puts "  #{Province.count} provinces created"

# ── ADMIN USER ──
puts "Creating admin user..."
User.create!(
  name:                  "Admin User",
  email:                 "admin@wpgcomfort.com",
  password:              "password123",
  password_confirmation: "password123",
  admin:                 true,
  province:              Province.find_by(code: "MB")
)
puts "  Admin: admin@wpgcomfort.com / password123"

# ── HOTELS (3 Winnipeg locations from proposal) ──
puts "Seeding hotels..."
hotel1 = Hotel.create!(name: "Winnipeg Comfort Downtown",   address: "333 Portage Ave",      city: "Winnipeg", description: "Our flagship downtown hotel located in the heart of Winnipeg's business district, steps away from the MTS Centre and major corporate offices.")
hotel2 = Hotel.create!(name: "Winnipeg Comfort Polo Park",  address: "1485 Portage Ave",     city: "Winnipeg", description: "Conveniently located near Polo Park Shopping Centre and the airport, perfect for shoppers and transit travellers.")
hotel3 = Hotel.create!(name: "Winnipeg Comfort The Forks",  address: "1 Forks Market Rd",    city: "Winnipeg", description: "Nestled near The Forks National Historic Site, our third location offers stunning river views and easy access to Winnipeg's best attractions.")
puts "  #{Hotel.count} hotels created"

# ── CATEGORIES (4 room types from proposal) ──
puts "Seeding categories..."
standard = Category.create!(name: "Standard",  description: "Comfortable and affordable standard rooms perfect for solo travellers and couples on a budget.")
deluxe   = Category.create!(name: "Deluxe",    description: "Upgraded rooms with premium furnishings, larger beds, and enhanced amenities for a superior stay.")
suite    = Category.create!(name: "Suite",      description: "Spacious multi-room suites ideal for families and extended stays with full living areas.")
business = Category.create!(name: "Business",  description: "Professionally equipped rooms designed for business travellers with workstations and high-speed internet.")
puts "  #{Category.count} categories created"

# ── ROOMS ──
puts "Seeding rooms..."

rooms_data = [
  { hotel: hotel1, name: "Downtown Standard Queen",       room_type: "Standard", price: 89.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Daily Housekeeping",                        description: "A cozy and well-appointed standard queen room located in the heart of downtown Winnipeg. Features modern decor, comfortable bedding, and all the essentials for a pleasant stay." },
  { hotel: hotel1, name: "Downtown Standard Twin",        room_type: "Standard", price: 79.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Daily Housekeeping",                        description: "Our twin bed standard room is perfect for two guests travelling together. Comfortable individual beds with quality linens and a bright, clean bathroom." },
  { hotel: hotel1, name: "Downtown Standard King",        room_type: "Standard", price: 99.00,  capacity: 2, on_sale: true,  sale_price: 79.00,  amenities: "Free WiFi, TV, Mini Fridge, Coffee Maker",                               description: "A spacious standard king room with a plush king-size bed and modern amenities. Located on the upper floors with great views of downtown Winnipeg." },
  { hotel: hotel1, name: "Downtown Standard City View",   room_type: "Standard", price: 95.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, City View, Coffee Maker",                                 description: "Enjoy stunning views of Winnipeg's skyline from this comfortable standard room. Floor-to-ceiling windows let in natural light and provide a memorable backdrop." },
  { hotel: hotel1, name: "Downtown Standard Accessible",  room_type: "Standard", price: 85.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Roll-In Shower, Accessibility Features",                  description: "A fully accessible standard room designed to accommodate guests with mobility needs. Features a roll-in shower, lower bed height, and wide doorways throughout." },
  { hotel: hotel1, name: "Downtown Standard Single",      room_type: "Standard", price: 69.00,  capacity: 1, on_sale: true,  sale_price: 55.00,  amenities: "Free WiFi, TV, Work Desk, Coffee Maker",                                 description: "Our most affordable option for solo travellers. A compact yet comfortable single room with everything you need for a short business or leisure stay in Winnipeg." },
  { hotel: hotel1, name: "Downtown Standard Premium",     room_type: "Standard", price: 109.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Mini Fridge, Premium Toiletries",                   description: "An upgraded standard experience with premium bedding, smart TV, and high-end toiletries. The perfect balance between comfort and value in the heart of the city." },
  { hotel: hotel1, name: "Downtown Standard Corner",      room_type: "Standard", price: 105.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Corner Views, Coffee Maker, Bathtub",                     description: "A uniquely positioned corner room offering panoramic views of two city streets. Features a traditional bathtub and enhanced natural lighting from multiple windows." },
  { hotel: hotel1, name: "Downtown Standard Long Stay",   room_type: "Standard", price: 75.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Kitchenette, Washer/Dryer, Coffee Maker",                 description: "Designed for guests staying a week or longer, this room includes a small kitchenette and in-room washer/dryer. Great value for extended business or family visits." },
  { hotel: hotel1, name: "Downtown Standard Budget",      room_type: "Standard", price: 65.00,  capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker",                                            description: "Our most economical downtown option without compromising on cleanliness or comfort. A great base for exploring everything Winnipeg has to offer on a budget." },
  { hotel: hotel1, name: "Downtown Deluxe Queen",         room_type: "Deluxe",   price: 149.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, 55in Smart TV, Mini Bar, Premium Bedding, Bathtub",           description: "Step up your stay with our Deluxe Queen room featuring premium bedding, a fully stocked mini bar, and a luxurious soaking bathtub. Elegant decor and superior comfort." },
  { hotel: hotel1, name: "Downtown Deluxe King",          room_type: "Deluxe",   price: 169.00, capacity: 2, on_sale: true,  sale_price: 139.00, amenities: "Free WiFi, Smart TV, Mini Bar, Espresso Machine, Bathtub",               description: "Our most popular deluxe room featuring a king-size bed with pillow-top mattress, espresso machine, and a marble bathroom with a deep soaking tub." },
  { hotel: hotel1, name: "Downtown Deluxe Twin",          room_type: "Deluxe",   price: 145.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Mini Bar, Premium Linens, Rain Shower",             description: "A sophisticated twin room with premium linens and a stunning rain shower. Ideal for colleagues travelling together who want a step above the standard experience." },
  { hotel: hotel1, name: "Downtown Deluxe City View",     room_type: "Deluxe",   price: 179.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Mini Bar, Panoramic View, Bathtub",                 description: "Experience Winnipeg from above in this high-floor deluxe room with panoramic city views. Floor-to-ceiling windows frame a stunning cityscape day and night." },
  { hotel: hotel1, name: "Downtown Deluxe Corner",        room_type: "Deluxe",   price: 185.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Mini Bar, Corner Views, Jacuzzi Tub",               description: "The crown jewel of our deluxe category, this corner room features a private Jacuzzi tub and unobstructed views in two directions over the Winnipeg skyline." },
  { hotel: hotel1, name: "Downtown Deluxe Romantic",      room_type: "Deluxe",   price: 195.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Champagne, Rose Petals, Jacuzzi, Candles",          description: "Create unforgettable memories in our specially curated romantic deluxe room. Arrive to champagne on ice, rose petal turndown, and candlelit ambiance." },
  { hotel: hotel1, name: "Downtown Deluxe Pool View",     room_type: "Deluxe",   price: 159.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Mini Bar, Pool Access, Premium Toiletries",         description: "Overlooking our heated indoor pool, this deluxe room is perfect for guests who love to swim. Complimentary pool access included with every night's stay." },
  { hotel: hotel1, name: "Downtown Deluxe Studio",        room_type: "Deluxe",   price: 175.00, capacity: 3, on_sale: true,  sale_price: 149.00, amenities: "Free WiFi, Smart TV, Kitchenette, Sofa Bed, Mini Bar",                   description: "A versatile studio-style deluxe room with a separate sitting area and kitchenette. Perfect for guests who need a little more space and the comforts of home." },
  { hotel: hotel1, name: "Downtown Deluxe Accessible",    room_type: "Deluxe",   price: 155.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Roll-In Shower, Accessibility Features, Mini Bar",  description: "Our fully accessible deluxe room combines premium amenities with thoughtful accessibility features, ensuring a comfortable and dignified stay for all guests." },
  { hotel: hotel1, name: "Downtown Deluxe Premium",       room_type: "Deluxe",   price: 199.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Mini Bar, Premium Spa Kit, Turndown Service",       description: "The pinnacle of our deluxe category with nightly turndown service, a premium spa kit, and the finest linens in the hotel. A truly indulgent downtown experience." },
  { hotel: hotel1, name: "Downtown Junior Suite",         room_type: "Suite",    price: 229.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Living Area, Mini Bar, Espresso Machine, Bathtub",  description: "Our entry-level suite featuring a separate living area with sofa, dining table, and a bedroom with a king-size bed. Great for guests needing extra space." },
  { hotel: hotel1, name: "Downtown Executive Suite",      room_type: "Suite",    price: 299.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Full Living Room, Kitchenette, Mini Bar, Bathtub",  description: "A full executive suite with a separate bedroom, spacious living room, and a kitchenette with bar seating. Ideal for longer stays or entertaining business guests." },
  { hotel: hotel1, name: "Downtown Family Suite",         room_type: "Suite",    price: 279.00, capacity: 5, on_sale: true,  sale_price: 239.00, amenities: "Free WiFi, 2x Smart TV, 2 Bedrooms, Full Kitchen, Laundry",              description: "Our two-bedroom family suite is designed with families in mind, featuring a full kitchen, two bathrooms, and separate living space for parents and children." },
  { hotel: hotel1, name: "Downtown Penthouse Suite",      room_type: "Suite",    price: 499.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Private Terrace, Full Kitchen, Jacuzzi, Butler",    description: "The crown jewel of our hotel, this top-floor penthouse suite features a private outdoor terrace, full gourmet kitchen, Jacuzzi, and dedicated butler service." },
  { hotel: hotel1, name: "Downtown Honeymoon Suite",      room_type: "Suite",    price: 349.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Champagne, Jacuzzi, Rose Petal Turndown, Fireplace", description: "Celebrate your love in our stunning honeymoon suite featuring a fireplace, Jacuzzi for two, and romantic turndown service with champagne and chocolate." },
  { hotel: hotel1, name: "Downtown Presidential Suite",   room_type: "Suite",    price: 599.00, capacity: 6, on_sale: false, sale_price: nil,    amenities: "Free WiFi, 3x Smart TV, 3 Bedrooms, Full Kitchen, Dining Room, Butler",  description: "Our most prestigious accommodation spanning three bedrooms, a formal dining room, gourmet kitchen, and multiple luxury bathrooms with butler and concierge service." },
  { hotel: hotel1, name: "Downtown Accessible Suite",     room_type: "Suite",    price: 249.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Roll-In Shower, Wide Doorways, Living Area",        description: "A spacious accessible suite with full living area, ensuring guests with mobility needs can enjoy a premium, comfortable, and dignified hotel experience." },
  { hotel: hotel1, name: "Downtown Corner Suite",         room_type: "Suite",    price: 329.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Corner Views, Full Bar, Jacuzzi, Living Area",      description: "A spectacular corner suite with wraparound views of downtown Winnipeg, a well-stocked full bar, and a private Jacuzzi in the master bathroom." },
  { hotel: hotel1, name: "Downtown Business Single",      room_type: "Business", price: 119.00, capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Large Desk, Ergonomic Chair, Printer Access, Coffee Maker", description: "Purpose-built for the solo business traveller, this room features a large dedicated work desk, ergonomic chair, printer access, and high-speed fibre internet." },
  { hotel: hotel1, name: "Downtown Business King",        room_type: "Business", price: 149.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Large Desk, Ergonomic Chair, Meeting Table, Mini Bar",     description: "A premium business king room with a king bed for restful sleep and a dedicated work zone with meeting table for two, ideal for small client meetings." },
  { hotel: hotel1, name: "Downtown Business Suite",       room_type: "Business", price: 249.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Conference Table, Smart TV, Full Bar, Printer, Presentation Screen", description: "Our flagship business suite with a full conference table for up to six, presentation screen, high-speed internet, and premium overnight accommodations." },
  { hotel: hotel1, name: "Downtown Business Club",        room_type: "Business", price: 189.00, capacity: 2, on_sale: true,  sale_price: 159.00, amenities: "Free WiFi, Club Lounge Access, Smart TV, Work Desk, Breakfast Included",         description: "Club floor access included with this business room, granting entry to our executive lounge with complimentary breakfast, evening cocktails, and dedicated business services." },
  { hotel: hotel1, name: "Downtown Business Deluxe",      room_type: "Business", price: 179.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Dual Monitors, Standing Desk, Ergonomic Chair, Mini Bar",   description: "Featuring dual monitor setup and a height-adjustable standing desk, this room is the ultimate productivity environment for the modern business professional." },
  { hotel: hotel1, name: "Downtown Business Long Stay",   room_type: "Business", price: 135.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Work Desk, Kitchenette, Washer/Dryer, Weekly Rate",         description: "Designed for extended business trips, this room offers weekly rates, a kitchenette, in-suite laundry, and all the workspace essentials to stay productive." },
  { hotel: hotel1, name: "Downtown Business Meeting Pod", room_type: "Business", price: 199.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Video Conferencing, Whiteboard, Smart TV, Printer, Refreshments",     description: "A hybrid room and meeting space with professional video conferencing setup, whiteboard, and refreshment service. Book by night or by the day for client meetings." },
  { hotel: hotel2, name: "Polo Park Standard Queen",      room_type: "Standard", price: 82.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Daily Housekeeping, Free Parking",                   description: "A comfortable standard queen room at our Polo Park location, minutes from the shopping centre and airport. Complimentary parking included with every stay." },
  { hotel: hotel2, name: "Polo Park Standard King",       room_type: "Standard", price: 92.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Free Parking, Mini Fridge",                          description: "Our king standard room at Polo Park features a plush king bed, mini fridge for snacks, and free parking - perfect for travellers arriving by car." },
  { hotel: hotel2, name: "Polo Park Standard Twin",       room_type: "Standard", price: 75.00,  capacity: 2, on_sale: true,  sale_price: 62.00,  amenities: "Free WiFi, TV, Free Parking, Coffee Maker",                                       description: "Two comfortable twin beds in a well-appointed room near Polo Park. Great for friends or colleagues sharing a room who need their own comfortable sleeping space." },
  { hotel: hotel2, name: "Polo Park Standard Airport",    room_type: "Standard", price: 88.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Free Airport Shuttle, Free Parking, Coffee Maker",                  description: "Our airport-adjacent standard room comes with complimentary shuttle service to and from Winnipeg James Armstrong Richardson International Airport." },
  { hotel: hotel2, name: "Polo Park Standard Single",     room_type: "Standard", price: 65.00,  capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Free Parking, Coffee Maker, Work Desk",                            description: "An affordable single room ideal for solo travellers passing through Winnipeg. Includes free parking and a small work desk for light business tasks." },
  { hotel: hotel2, name: "Polo Park Standard Premium",    room_type: "Standard", price: 102.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Mini Bar, Premium Toiletries",                  description: "Our premium standard at Polo Park features elevated amenities including a smart TV, mini bar, and premium bathroom products for a step-up in comfort." },
  { hotel: hotel2, name: "Polo Park Standard Family",     room_type: "Standard", price: 98.00,  capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Free Parking, Rollaway Bed, Mini Fridge",                          description: "A spacious standard room with a rollaway bed option, perfect for small families visiting Polo Park Shopping Centre, the zoo, or other Winnipeg attractions." },
  { hotel: hotel2, name: "Polo Park Standard Pet Friendly", room_type: "Standard", price: 95.00, capacity: 2, on_sale: false, sale_price: nil,   amenities: "Free WiFi, TV, Free Parking, Pet Friendly, Pet Bed Provided",                     description: "Travelling with your furry friend? Our pet-friendly standard room welcomes dogs and cats. A pet bed and food bowl are provided at no extra charge." },
  { hotel: hotel2, name: "Polo Park Standard Budget",     room_type: "Standard", price: 59.00,  capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Free Parking, Coffee Maker",                                       description: "The most affordable room in our Polo Park location without sacrificing cleanliness or basic comfort. Ideal for budget-conscious travellers and backpackers." },
  { hotel: hotel2, name: "Polo Park Deluxe Queen",        room_type: "Deluxe",   price: 139.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Mini Bar, Premium Bedding",                    description: "A beautifully appointed deluxe queen room at Polo Park featuring premium bedding, mini bar, and smart TV. Free parking included for all overnight guests." },
  { hotel: hotel2, name: "Polo Park Deluxe King",         room_type: "Deluxe",   price: 159.00, capacity: 2, on_sale: true,  sale_price: 129.00, amenities: "Free WiFi, Smart TV, Free Parking, Mini Bar, Jacuzzi Tub",                        description: "Indulge in our Polo Park Deluxe King room featuring a Jacuzzi tub, king bed with pillow-top mattress, and complimentary parking. Perfect for a romantic getaway." },
  { hotel: hotel2, name: "Polo Park Deluxe Airport View", room_type: "Deluxe",   price: 149.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Airport Shuttle, Mini Bar",                    description: "A unique deluxe experience with views of the airport runway - perfect for aviation enthusiasts. Complimentary shuttle service takes you directly to departures." },
  { hotel: hotel2, name: "Polo Park Deluxe Twin",         room_type: "Deluxe",   price: 145.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Mini Bar, Rain Shower",                        description: "Elevated twin accommodation with premium individual beds, rain shower experience, and mini bar. Great for two guests who want a superior shared room." },
  { hotel: hotel2, name: "Polo Park Deluxe Corner",       room_type: "Deluxe",   price: 169.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Corner Views, Jacuzzi",                        description: "A corner deluxe room with expansive windows and a private Jacuzzi. Enjoy views of the Polo Park area while relaxing in luxury after a long day." },
  { hotel: hotel2, name: "Polo Park Deluxe Studio",       room_type: "Deluxe",   price: 155.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Kitchenette, Sofa Bed, Mini Bar",              description: "A versatile studio deluxe room with a kitchenette and pullout sofa. Ideal for small families or guests who want home-like convenience with hotel luxury." },
  { hotel: hotel2, name: "Polo Park Deluxe Pet Friendly", room_type: "Deluxe",   price: 149.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Pet Friendly, Pet Amenities Kit",              description: "Our pet-friendly deluxe room offers premium amenities for both you and your pet. Includes a pet amenities kit with bed, treats, and cleanup supplies." },
  { hotel: hotel2, name: "Polo Park Deluxe Premium",      room_type: "Deluxe",   price: 179.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Spa Kit, Turndown Service, Mini Bar",          description: "The pinnacle of our Polo Park deluxe category with nightly turndown service, luxury spa kit, and premium mini bar. A truly restorative stay near the airport." },
  { hotel: hotel2, name: "Polo Park Deluxe Long Stay",    room_type: "Deluxe",   price: 129.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Kitchenette, Washer/Dryer, Weekly Rate",       description: "Extended stay pricing for our Polo Park deluxe room. Includes kitchenette, in-suite laundry, and all premium deluxe amenities at a discounted weekly rate." },
  { hotel: hotel2, name: "Polo Park Junior Suite",        room_type: "Suite",    price: 209.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Living Area, Mini Bar, Bathtub",               description: "Our Polo Park junior suite features a separate living room with sofa and a king bedroom. Free parking and complimentary airport shuttle make travel effortless." },
  { hotel: hotel2, name: "Polo Park Family Suite",        room_type: "Suite",    price: 259.00, capacity: 6, on_sale: true,  sale_price: 219.00, amenities: "Free WiFi, 2x Smart TV, Free Parking, 2 Bedrooms, Full Kitchen",                  description: "Perfect for families visiting Winnipeg, our two-bedroom suite has a full kitchen, two bathrooms, and bunk beds in the second bedroom for kids." },
  { hotel: hotel2, name: "Polo Park Executive Suite",     room_type: "Suite",    price: 289.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Living Room, Kitchenette, Mini Bar",            description: "A spacious executive suite near the airport with a full living room, kitchenette, and business-ready workspace. Ideal for executives in transit." },
  { hotel: hotel2, name: "Polo Park Honeymoon Suite",     room_type: "Suite",    price: 329.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Jacuzzi, Champagne, Fireplace",                description: "Celebrate your love at our Polo Park honeymoon suite with fireplace, couples Jacuzzi, and complimentary champagne and strawberries on arrival." },
  { hotel: hotel2, name: "Polo Park Pet Suite",           room_type: "Suite",    price: 245.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Pet Friendly, Living Area, Pet Amenities",     description: "Our only pet-friendly suite offers a spacious living area, separate bedroom, and a full pet amenities package for your furry travel companion." },
  { hotel: hotel2, name: "Polo Park Accessible Suite",    room_type: "Suite",    price: 239.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Roll-In Shower, Wide Doorways, Living Area",   description: "A fully accessible suite ensuring guests with mobility needs can enjoy premium suite accommodations with all necessary accessibility features throughout." },
  { hotel: hotel2, name: "Polo Park Corner Suite",        room_type: "Suite",    price: 309.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Corner Views, Jacuzzi, Full Bar",              description: "Our corner suite at Polo Park offers panoramic views, a well-stocked full bar, and private Jacuzzi in the master bathroom for an unforgettable stay." },
  { hotel: hotel2, name: "Polo Park Business King",       room_type: "Business", price: 139.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Large Desk, Ergonomic Chair, Airport Shuttle", description: "A business-focused king room near the airport with complimentary shuttle service. Features a large work desk, ergonomic chair, and high-speed business internet." },
  { hotel: hotel2, name: "Polo Park Business Suite",      room_type: "Business", price: 229.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Conference Table, Free Parking, Smart TV, Printer, Airport Shuttle",   description: "A professional business suite with conference table, presentation setup, and airport shuttle included. Perfect for business travellers and small team meetings." },
  { hotel: hotel2, name: "Polo Park Business Long Stay",  room_type: "Business", price: 119.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Work Desk, Kitchenette, Weekly Rate",          description: "Extended business stay room with weekly pricing, kitchenette, and all business essentials. Free parking and airport shuttle make this ideal for frequent travellers." },
  { hotel: hotel2, name: "Polo Park Business Club",       room_type: "Business", price: 169.00, capacity: 2, on_sale: true,  sale_price: 145.00, amenities: "Free WiFi, Club Lounge, Free Parking, Smart TV, Breakfast, Airport Shuttle",       description: "Club level business room with lounge access, complimentary breakfast, evening drinks, and airport shuttle. Everything a business traveller needs in one package." },
  { hotel: hotel2, name: "Polo Park Business Single",     room_type: "Business", price: 109.00, capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Free Parking, Large Desk, Ergonomic Chair, Coffee Maker",    description: "An efficient single business room for the solo traveller. Ergonomic setup, high-speed internet, and free parking make this a smart choice near the airport." },
  { hotel: hotel3, name: "Forks Standard River View",     room_type: "Standard", price: 94.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, River View, Coffee Maker, Daily Housekeeping",                     description: "Wake up to stunning views of the Red and Assiniboine Rivers from this comfortable standard room. Located at The Forks, Winnipeg's most historic meeting place." },
  { hotel: hotel3, name: "Forks Standard Market View",    room_type: "Standard", price: 86.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Market View, Coffee Maker, Daily Housekeeping",                    description: "Overlooking the vibrant Forks Market, this standard room puts you in the centre of Winnipeg's best dining, shopping, and cultural experiences." },
  { hotel: hotel3, name: "Forks Standard Queen",          room_type: "Standard", price: 84.00,  capacity: 2, on_sale: true,  sale_price: 69.00,  amenities: "Free WiFi, TV, Coffee Maker, Daily Housekeeping",                                description: "A comfortable queen standard room at The Forks location. Steps from the market, skating rink in winter, and river walk trails in summer." },
  { hotel: hotel3, name: "Forks Standard Twin",           room_type: "Standard", price: 79.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Daily Housekeeping, River Access",                   description: "Twin beds standard room with easy access to the outdoor river walkways. A great base for exploring The Forks National Historic Site and surrounding attractions." },
  { hotel: hotel3, name: "Forks Standard King",           room_type: "Standard", price: 99.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Mini Fridge, River View",                           description: "A well-appointed king standard room with river views and a mini fridge for convenience. Enjoy mornings watching boat traffic on the Red River." },
  { hotel: hotel3, name: "Forks Standard Single",         room_type: "Standard", price: 68.00,  capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Coffee Maker, Daily Housekeeping",                                description: "Our most affordable Forks location room, perfect for solo explorers wanting to experience Winnipeg's most celebrated historic site and riverfront district." },
  { hotel: hotel3, name: "Forks Standard Historic",       room_type: "Standard", price: 92.00,  capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, TV, Historic Decor, Coffee Maker, Guided Tour Voucher",               description: "Immerse yourself in Winnipeg's rich history with our heritage-themed standard room featuring locally inspired decor and a complimentary guided Forks historic tour." },
  { hotel: hotel3, name: "Forks Standard Premium",        room_type: "Standard", price: 108.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Mini Bar, Premium Toiletries",                   description: "Our premium standard at The Forks combines elevated amenities with unbeatable river views. Smart TV, mini bar, and premium toiletries included." },
  { hotel: hotel3, name: "Forks Deluxe River View",       room_type: "Deluxe",   price: 169.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Mini Bar, Bathtub, Premium Bedding",             description: "Our signature Forks deluxe experience with stunning river views, premium bedding, a soaking bathtub, and a well-stocked mini bar. Truly memorable." },
  { hotel: hotel3, name: "Forks Deluxe King",             room_type: "Deluxe",   price: 179.00, capacity: 2, on_sale: true,  sale_price: 149.00, amenities: "Free WiFi, Smart TV, Mini Bar, Jacuzzi, River View",                              description: "A premium king deluxe room with river views and a private Jacuzzi. Watch the sunset over the Assiniboine River from the comfort of your room." },
  { hotel: hotel3, name: "Forks Deluxe Heritage",         room_type: "Deluxe",   price: 185.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Heritage Decor, Mini Bar, Guided Tour, Bathtub",             description: "Experience Winnipeg's layered history in this beautifully designed heritage deluxe room. Locally sourced artwork, indigenous-inspired textiles, and a clawfoot bathtub." },
  { hotel: hotel3, name: "Forks Deluxe Corner",           room_type: "Deluxe",   price: 195.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Corner River Views, Mini Bar, Jacuzzi",                      description: "The best views in the hotel, this corner deluxe room offers sweeping vistas of both the Red and Assiniboine Rivers converging at The Forks." },
  { hotel: hotel3, name: "Forks Deluxe Romantic",         room_type: "Deluxe",   price: 199.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Champagne, Rose Petals, Jacuzzi",               description: "Set the perfect romantic scene with river views, rose petal turndown, champagne on arrival, and a couples Jacuzzi. Winnipeg's most romantic hotel room." },
  { hotel: hotel3, name: "Forks Deluxe Studio",           room_type: "Deluxe",   price: 175.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Kitchenette, Sofa Bed, Mini Bar",               description: "A spacious studio deluxe with river views, kitchenette, and pullout sofa. Great for small families or guests who want extra space at The Forks." },
  { hotel: hotel3, name: "Forks Deluxe Accessible",       room_type: "Deluxe",   price: 165.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Roll-In Shower, Accessibility Features",        description: "Fully accessible deluxe room with river views and all necessary mobility features. Everyone deserves to experience the beauty of The Forks in comfort." },
  { hotel: hotel3, name: "Forks Deluxe Premium",          room_type: "Deluxe",   price: 209.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Panoramic River View, Spa Kit, Turndown, Mini Bar",          description: "The finest non-suite room at The Forks location, featuring panoramic river views, a luxury spa kit, nightly turndown service, and premium mini bar selections." },
  { hotel: hotel3, name: "Forks Junior Suite",            room_type: "Suite",    price: 249.00, capacity: 3, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Living Area, Mini Bar, Bathtub",                 description: "Our entry-level Forks suite with river views from both the bedroom and living area. A separate seating area with sofa makes this a comfortable retreat." },
  { hotel: hotel3, name: "Forks Executive Suite",         room_type: "Suite",    price: 319.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Panoramic River View, Full Kitchen, Mini Bar",               description: "An executive suite spanning the full width of the building with panoramic river views from every window, full kitchen, and premium furnishings throughout." },
  { hotel: hotel3, name: "Forks Family Suite",            room_type: "Suite",    price: 289.00, capacity: 6, on_sale: true,  sale_price: 249.00, amenities: "Free WiFi, 2x Smart TV, River View, 2 Bedrooms, Full Kitchen",                    description: "A two-bedroom family suite with full kitchen and river views. Kids will love the bunk room while parents enjoy the master bedroom and private river view balcony." },
  { hotel: hotel3, name: "Forks Penthouse Suite",         room_type: "Suite",    price: 549.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Private Terrace, Panoramic River Views, Full Kitchen, Butler", description: "The crown jewel of our portfolio, the Forks Penthouse offers 360-degree river views from a private terrace, gourmet kitchen, and dedicated butler service." },
  { hotel: hotel3, name: "Forks Honeymoon Suite",         room_type: "Suite",    price: 379.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View Jacuzzi, Champagne, Fireplace, Rose Petals",      description: "Our most romantic suite features a Jacuzzi overlooking the river, fireplace, and bespoke honeymoon package with champagne, roses, and chocolate." },
  { hotel: hotel3, name: "Forks Heritage Suite",          room_type: "Suite",    price: 359.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, Historic Decor, River View, Full Kitchen, Guided Tour",      description: "A one-of-a-kind heritage suite celebrating Winnipeg's history through locally commissioned artwork, indigenous textiles, and artifacts. Includes a private guided tour." },
  { hotel: hotel3, name: "Forks Accessible Suite",        room_type: "Suite",    price: 269.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Roll-In Shower, Wide Doorways, Living Area",     description: "A fully accessible suite with river views, ensuring guests with mobility needs can enjoy the full suite experience at our beautiful Forks location." },
  { hotel: hotel3, name: "Forks Presidential Suite",      room_type: "Suite",    price: 649.00, capacity: 6, on_sale: false, sale_price: nil,    amenities: "Free WiFi, 3x Smart TV, Panoramic River Views, 3 Bedrooms, Full Kitchen, Private Chef", description: "The most prestigious accommodation in all of Winnipeg. Three bedrooms, panoramic river views, private chef on request, and unparalleled luxury at The Forks." },
  { hotel: hotel3, name: "Forks Business King",           room_type: "Business", price: 145.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Large Desk, Ergonomic Chair, Coffee Maker",      description: "Stay productive with river views in this business king room. Features a large dedicated workspace, ergonomic chair, and fibre internet for video conferencing." },
  { hotel: hotel3, name: "Forks Business Suite",          room_type: "Business", price: 259.00, capacity: 4, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Conference Table, Smart TV, River View, Printer, Whiteboard",          description: "A professional business suite with river views and full conference setup. The most inspiring meeting room in Winnipeg, perfect for creative strategy sessions." },
  { hotel: hotel3, name: "Forks Business Club",           room_type: "Business", price: 195.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Club Lounge, Smart TV, River View, Work Desk, Breakfast",              description: "Club floor access with river views, executive lounge privileges, breakfast, and evening cocktails included. The complete business traveller experience." },
  { hotel: hotel3, name: "Forks Business Long Stay",      room_type: "Business", price: 129.00, capacity: 2, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Work Desk, Kitchenette, Weekly Rate",            description: "Weekly-rate business room with river views and kitchenette. Enjoy the beauty of The Forks while staying productive on an extended business assignment." },
  { hotel: hotel3, name: "Forks Business Deluxe",         room_type: "Business", price: 185.00, capacity: 2, on_sale: true,  sale_price: 159.00, amenities: "Free WiFi, Smart TV, River View, Dual Monitors, Standing Desk, Mini Bar",          description: "A premium business setup with dual monitors, standing desk, and river views. The ideal environment for focused work with inspiring natural scenery." },
  { hotel: hotel3, name: "Forks Business Single",         room_type: "Business", price: 115.00, capacity: 1, on_sale: false, sale_price: nil,    amenities: "Free WiFi, Smart TV, River View, Large Desk, Ergonomic Chair",                    description: "An efficient single business room with river views. Everything a solo business traveller needs in a compact, well-designed, and inspiring space at The Forks." },
]

rooms_data.each do |data|
  room = Room.create!(
    hotel:       data[:hotel],
    name:        data[:name],
    room_type:   data[:room_type],
    price:       data[:price],
    sale_price:  data[:sale_price],
    capacity:    data[:capacity],
    description: data[:description],
    amenities:   data[:amenities],
    available:   true,
    on_sale:     data[:on_sale] || false
  )

  category = case data[:room_type]
             when "Standard" then standard
             when "Deluxe"   then deluxe
             when "Suite"    then suite
             when "Business" then business
             end

  RoomCategory.create!(room: room, category: category)
end

puts "  #{Room.count} rooms created"
# Feature 1.7 - Scrape additional room data from books.toscrape.com
puts 'Scraping additional room data from web...'
require 'httparty'
require 'nokogiri'

begin
  response = HTTParty.get('http://books.toscrape.com/catalogue/page-1.html')
  doc = Nokogiri::HTML(response.body)
  scraped_count = 0

  doc.css('article.product_pod').each_with_index do |item, index|
    break if scraped_count >= 20

    title = item.css('h3 a').attr('title').value rescue "Scraped Room #{index + 1}"
    price_text = item.css('.price_color').text.strip
    price = price_text.gsub(/[^0-9.]/, '').to_f
    price = (price * 1.5).round(2)
    price = [price, 49.99].max

    rating_class = item.css('.star-rating').attr('class').value rescue 'star-rating Three'
    rating = rating_class.split.last
    on_sale = %w[One Two].include?(rating)
    sale_price = on_sale ? (price * 0.85).round(2) : nil

    hotels = [hotel1, hotel2, hotel3]
    categories = [standard, deluxe, suite, business]
    room_types = %w[Standard Deluxe Suite Business]

    hotel = hotels[index % 3]
    category = categories[index % 4]
    room_type = room_types[index % 4]

    room_name = "#{hotel.name.split.last} Scraped #{title.truncate(25)}"

    room = Room.create!(
      hotel:       hotel,
      name:        room_name,
      room_type:   room_type,
      price:       price,
      sale_price:  sale_price,
      capacity:    rand(1..6),
      description: "#{title} - A comfortable #{room_type.downcase} room at our #{hotel.name} location with premium amenities and excellent service.",
      amenities:   'Free WiFi, TV, Coffee Maker, Daily Housekeeping',
      available:   true,
      on_sale:     on_sale
    )

    RoomCategory.create!(room: room, category: category)
    scraped_count += 1
  end

  puts "  #{scraped_count} rooms scraped and added"
rescue StandardError => e
  puts "  Scraping skipped: #{e.message}"
end

puts "  #{Room.count} total rooms"

# ── PAGES ──
puts "Seeding pages..."
Page.create!(
  slug:    "about",
  title:   "About Winnipeg Comfort Hotels",
  content: "Winnipeg Comfort Hotels has been serving guests in Winnipeg, Manitoba for over 10 years.\n\nWe operate three hotel locations across the city, providing comfortable accommodation for tourists, business travelers, and families visiting Winnipeg.\n\nOur team of 25 dedicated staff members including hotel management, housekeeping, and customer service representatives work tirelessly to ensure every guest has an exceptional stay.\n\nWhether you are visiting for business, attending a conference, exploring the city, or bringing the family for a vacation, we have the perfect room for you."
)

Page.create!(
  slug:    "contact",
  title:   "Contact Us",
  content: "We would love to hear from you!\n\nDowntown Location\n333 Portage Ave, Winnipeg, MB\nPhone: (204) 555-0100\n\nPolo Park Location\n1485 Portage Ave, Winnipeg, MB\nPhone: (204) 555-0200\n\nThe Forks Location\n1 Forks Market Rd, Winnipeg, MB\nPhone: (204) 555-0300\n\nGeneral Inquiries\nEmail: info@wpgcomforthotels.com\nToll Free: 1-800-555-0100\n\nOur reservations team is available 24 hours a day, 7 days a week."
)

puts "  Pages created"
puts ""
puts "========================================="
puts "Seeding complete!"
puts "  #{Province.count} provinces"
puts "  #{Hotel.count} hotels"
puts "  #{Category.count} categories"
puts "  #{Room.count} rooms"
puts "  #{Page.count} pages"
puts ""
puts "Admin login: admin@wpgcomfort.com"
puts "Password:    password123"
puts "========================================="