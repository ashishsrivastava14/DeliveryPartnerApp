class MockOrder {
  final String id;
  final String storeName;
  final String storeAddress;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final int itemsCount;
  final double distance;
  final double payout;
  final String status;
  final DateTime createdAt;
  final String? otp;

  MockOrder({
    required this.id,
    required this.storeName,
    required this.storeAddress,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.itemsCount,
    required this.distance,
    required this.payout,
    required this.status,
    required this.createdAt,
    this.otp,
  });
}

class MockOrders {
  static List<MockOrder> allOrders = [
    MockOrder(
      id: 'ORD-10234',
      storeName: 'FreshMart Superstore',
      storeAddress: '12, MG Road, Sector 14, Gurugram',
      customerName: 'Aarav Sharma',
      customerAddress: '45-B, Palm Residency, Sector 22, Gurugram',
      customerPhone: '+91 98765 43210',
      itemsCount: 5,
      distance: 3.2,
      payout: 45.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      otp: '5678',
    ),
    MockOrder(
      id: 'ORD-10235',
      storeName: 'QuickBasket',
      storeAddress: '78, Civil Lines, Sector 9, Noida',
      customerName: 'Priya Verma',
      customerAddress: '22, Lotus Boulevard, Sector 100, Noida',
      customerPhone: '+91 87654 32109',
      itemsCount: 3,
      distance: 2.1,
      payout: 35.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      otp: '4321',
    ),
    MockOrder(
      id: 'ORD-10236',
      storeName: 'Daily Needs Store',
      storeAddress: '5, Market Complex, Sector 15, Delhi',
      customerName: 'Rohit Patel',
      customerAddress: '90, Green Park Extension, Delhi',
      customerPhone: '+91 76543 21098',
      itemsCount: 8,
      distance: 4.5,
      payout: 62.0,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      otp: '1234',
    ),
    MockOrder(
      id: 'ORD-10237',
      storeName: 'Metro Groceries',
      storeAddress: '34, Rajouri Garden, Delhi',
      customerName: 'Sneha Gupta',
      customerAddress: '67, Dwarka Sector 12, Delhi',
      customerPhone: '+91 65432 10987',
      itemsCount: 2,
      distance: 5.8,
      payout: 75.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      otp: '9876',
    ),
    MockOrder(
      id: 'ORD-10238',
      storeName: 'Nature Fresh',
      storeAddress: '89, Connaught Place, Delhi',
      customerName: 'Vikram Singh',
      customerAddress: '12, Saket, Delhi',
      customerPhone: '+91 54321 09876',
      itemsCount: 6,
      distance: 3.7,
      payout: 52.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      otp: '6543',
    ),
    MockOrder(
      id: 'ORD-10239',
      storeName: 'Urban Basket',
      storeAddress: '56, Hauz Khas, Delhi',
      customerName: 'Anita Desai',
      customerAddress: '78, Greater Kailash, Delhi',
      customerPhone: '+91 43210 98765',
      itemsCount: 4,
      distance: 2.9,
      payout: 40.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      otp: '3210',
    ),
    MockOrder(
      id: 'ORD-10240',
      storeName: 'SuperMart Express',
      storeAddress: '23, Lajpat Nagar, Delhi',
      customerName: 'Karan Mehta',
      customerAddress: '45, Defence Colony, Delhi',
      customerPhone: '+91 32109 87654',
      itemsCount: 10,
      distance: 1.8,
      payout: 30.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      otp: '7890',
    ),
    MockOrder(
      id: 'ORD-10241',
      storeName: 'Green Valley Organics',
      storeAddress: '67, Vasant Kunj, Delhi',
      customerName: 'Deepa Nair',
      customerAddress: '90, Chanakyapuri, Delhi',
      customerPhone: '+91 21098 76543',
      itemsCount: 7,
      distance: 6.2,
      payout: 85.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      otp: '4567',
    ),
    MockOrder(
      id: 'ORD-10242',
      storeName: 'FreshMart Superstore',
      storeAddress: '12, MG Road, Sector 14, Gurugram',
      customerName: 'Anil Kumar',
      customerAddress: '34, DLF Phase 3, Gurugram',
      customerPhone: '+91 10987 65432',
      itemsCount: 3,
      distance: 2.5,
      payout: 38.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      otp: '2345',
    ),
    MockOrder(
      id: 'ORD-10243',
      storeName: 'QuickBasket',
      storeAddress: '78, Civil Lines, Sector 9, Noida',
      customerName: 'Meera Joshi',
      customerAddress: '56, Sector 62, Noida',
      customerPhone: '+91 09876 54321',
      itemsCount: 5,
      distance: 3.0,
      payout: 42.0,
      status: 'delivered',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      otp: '8901',
    ),
  ];

  static MockOrder get activeOrder => allOrders.firstWhere((o) => o.status == 'active');

  static MockOrder get newOrderAlert => MockOrder(
    id: 'ORD-10244',
    storeName: 'BigBasket Express',
    storeAddress: '90, Cyber Hub, Gurugram',
    customerName: 'Rajesh Kumar',
    customerAddress: '12, Golf Course Road, Gurugram',
    customerPhone: '+91 98765 00000',
    itemsCount: 4,
    distance: 2.8,
    payout: 55.0,
    status: 'pending',
    createdAt: DateTime.now(),
    otp: '1234',
  );

  static List<MockOrder> get todayOrders =>
      allOrders.where((o) => o.createdAt.day == DateTime.now().day).toList();

  static List<MockOrder> get weekOrders =>
      allOrders.where((o) => DateTime.now().difference(o.createdAt).inDays < 7).toList();
}
