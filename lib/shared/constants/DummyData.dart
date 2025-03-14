import 'package:day59/models/products/ProductModel.dart';

List<ProductModel> dummyProducts = [
  ProductModel(
    id: "p001",
    title: "Premium Leather Jacket",
    description:
        "Handcrafted genuine leather jacket with quilted lining and brass zippers. Perfect for all seasons.",
    category: "Clothing",
    price: 249.99,
    isAvailable: true,
    priceDescription: "Limited time offer",
    imageUrls: [
      {
        "image1":
            "https://images.unsplash.com/photo-1564584217132-2271feaeb3c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80"
      },
      {"cover_image": "https://picsum.photos/800/1200?random=2"},
    ],
  ),
  ProductModel(
    id: "p002",
    title: "Smart LED TV 55\"",
    description:
        "Ultra HD 4K resolution with HDR support. Smart features include voice control and streaming apps.",
    category: "Electronics",
    price: 699.99,
    isAvailable: true,
    priceDescription: "Free shipping included",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=3"},
      {"cover_image": "https://picsum.photos/800/1200?random=4"},
    ],
  ),
  ProductModel(
    id: "p003",
    title: "Ergonomic Office Chair",
    description:
        "Adjustable height and lumbar support. Breathable mesh backing and comfortable padding.",
    category: "Furniture",
    price: 189.50,
    isAvailable: true,
    priceDescription: "Assembly available",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=6"},
      {"cover_image": "https://picsum.photos/800/1200?random=5"},
    ],
  ),
  ProductModel(
    id: "p004",
    title: "Wireless Bluetooth Headphones",
    description:
        "Noise-canceling technology with 30-hour battery life. Premium sound quality and comfortable ear cups.",
    category: "Electronics",
    price: 149.99,
    isAvailable: false,
    priceDescription: "Back in stock soon",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=7"},
      {"cover_image": "https://picsum.photos/800/1200?random=8"},
    ],
  ),
  ProductModel(
    id: "p005",
    title: "Organic Cotton T-Shirt",
    description:
        "100% organic cotton. Sustainably made with eco-friendly dyes. Comfortable fit for everyday wear.",
    category: "Clothing",
    price: 29.99,
    isAvailable: true,
    priceDescription: "Buy 2 get 1 free",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=9"},
      {"cover_image": "https://picsum.photos/800/1200?random=10"},
    ],
  ),
  ProductModel(
    id: "p006",
    title: "Professional Chef Knife Set",
    description:
        "5-piece stainless steel knife set with ergonomic handles. Includes storage block and sharpening tool.",
    category: "Kitchen",
    price: 89.95,
    isAvailable: true,
    priceDescription: "Professional grade",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=11"},
      {"cover_image": "https://picsum.photos/800/1200?random=12"},
    ],
  ),
  ProductModel(
    id: "p007",
    title: "Fitness Smartwatch",
    description:
        "Track your workouts, heart rate, and sleep patterns. Water-resistant with 7-day battery life.",
    category: "Wearables",
    price: 129.99,
    isAvailable: true,
    priceDescription: "Includes 1-year warranty",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=13"},
      {"cover_image": "https://picsum.photos/800/1200?random=14"},
    ],
  ),
  ProductModel(
    id: "p008",
    title: "Designer Handbag",
    description:
        "Handcrafted luxury leather handbag with gold-plated hardware. Multiple compartments and adjustable strap.",
    category: "Clothing",
    price: 299.99,
    isAvailable: true,
    priceDescription: "Limited edition",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=15"},
      {"cover_image": "https://picsum.photos/800/1200?random=16"},
    ],
  ),
  ProductModel(
    id: "p009",
    title: "Portable Bluetooth Speaker",
    description:
        "Waterproof speaker with 360° sound. 24-hour playtime and built-in microphone for calls.",
    category: "Electronics",
    price: 79.99,
    isAvailable: true,
    priceDescription: "Free 2-day shipping",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=17"},
      {"cover_image": "https://picsum.photos/800/1200?random=18"},
    ],
  ),
  ProductModel(
    id: "p010",
    title: "Ceramic Plant Pot Set",
    description:
        "Set of 3 minimalist ceramic pots in varying sizes. Perfect for indoor plants and herbs.",
    category: "Wearables",
    price: 49.95,
    isAvailable: false,
    priceDescription: "Restocking next week",
    imageUrls: [
      {"image1": "https://picsum.photos/800/1200?random=19"},
      {"cover_image": "https://picsum.photos/800/1200?random=20"},
    ],
  ),
];
