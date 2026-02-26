class MockPartner {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String vehicleType;
  final String vehicleNumber;
  final String zone;
  final String status; // active, inactive, pending, suspended
  final String documentStatus; // approved, pending, rejected
  final int totalOrders;
  final double rating;
  final double totalEarnings;
  final String joinDate;
  final String profileImage;

  MockPartner({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.zone,
    required this.status,
    required this.documentStatus,
    required this.totalOrders,
    required this.rating,
    required this.totalEarnings,
    required this.joinDate,
    this.profileImage = '',
  });
}

class MockPartners {
  static List<MockPartner> allPartners = [
    MockPartner(
      id: 'DP-001',
      name: 'Amit Sharma',
      phone: '+91 98765 43210',
      email: 'amit.sharma@email.com',
      vehicleType: 'Bike',
      vehicleNumber: 'DL-01-AB-1234',
      zone: 'South Delhi',
      status: 'active',
      documentStatus: 'approved',
      totalOrders: 1250,
      rating: 4.8,
      totalEarnings: 185000,
      joinDate: '2024-03-15',
      profileImage: 'https://i.pravatar.cc/150?img=12',
    ),
    MockPartner(
      id: 'DP-002',
      name: 'Rajesh Kumar',
      phone: '+91 87654 32109',
      email: 'rajesh.k@email.com',
      vehicleType: 'Scooter',
      vehicleNumber: 'DL-02-CD-5678',
      zone: 'North Delhi',
      status: 'active',
      documentStatus: 'approved',
      totalOrders: 980,
      rating: 4.6,
      totalEarnings: 142000,
      joinDate: '2024-05-20',
      profileImage: 'https://i.pravatar.cc/150?img=15',
    ),
    MockPartner(
      id: 'DP-003',
      name: 'Suresh Patel',
      phone: '+91 76543 21098',
      email: 'suresh.p@email.com',
      vehicleType: 'Bike',
      vehicleNumber: 'HR-26-EF-9012',
      zone: 'Gurugram',
      status: 'inactive',
      documentStatus: 'approved',
      totalOrders: 450,
      rating: 4.3,
      totalEarnings: 67500,
      joinDate: '2024-08-10',
      profileImage: 'https://i.pravatar.cc/150?img=17',
    ),
    MockPartner(
      id: 'DP-004',
      name: 'Vikram Singh',
      phone: '+91 65432 10987',
      email: 'vikram.s@email.com',
      vehicleType: 'EV Bike',
      vehicleNumber: 'UP-16-GH-3456',
      zone: 'Noida',
      status: 'pending',
      documentStatus: 'pending',
      totalOrders: 0,
      rating: 0.0,
      totalEarnings: 0,
      joinDate: '2025-02-01',
      profileImage: 'https://i.pravatar.cc/150?img=22',
    ),
    MockPartner(
      id: 'DP-005',
      name: 'Deepak Verma',
      phone: '+91 54321 09876',
      email: 'deepak.v@email.com',
      vehicleType: 'Bike',
      vehicleNumber: 'DL-03-IJ-7890',
      zone: 'East Delhi',
      status: 'suspended',
      documentStatus: 'approved',
      totalOrders: 320,
      rating: 3.2,
      totalEarnings: 48000,
      joinDate: '2024-06-15',
      profileImage: 'https://i.pravatar.cc/150?img=33',
    ),
    MockPartner(
      id: 'DP-006',
      name: 'Manoj Tiwari',
      phone: '+91 43210 98765',
      email: 'manoj.t@email.com',
      vehicleType: 'Scooter',
      vehicleNumber: 'DL-04-KL-1234',
      zone: 'West Delhi',
      status: 'active',
      documentStatus: 'approved',
      totalOrders: 2100,
      rating: 4.9,
      totalEarnings: 315000,
      joinDate: '2023-11-20',
      profileImage: 'https://i.pravatar.cc/150?img=53',
    ),
    MockPartner(
      id: 'DP-007',
      name: 'Pradeep Yadav',
      phone: '+91 32109 87654',
      email: 'pradeep.y@email.com',
      vehicleType: 'Bike',
      vehicleNumber: 'HR-29-MN-5678',
      zone: 'Faridabad',
      status: 'active',
      documentStatus: 'approved',
      totalOrders: 780,
      rating: 4.5,
      totalEarnings: 117000,
      joinDate: '2024-04-10',
      profileImage: 'https://i.pravatar.cc/150?img=57',
    ),
    MockPartner(
      id: 'DP-008',
      name: 'Ravi Shankar',
      phone: '+91 21098 76543',
      email: 'ravi.s@email.com',
      vehicleType: 'EV Scooter',
      vehicleNumber: 'UP-14-OP-9012',
      zone: 'Ghaziabad',
      status: 'pending',
      documentStatus: 'pending',
      totalOrders: 0,
      rating: 0.0,
      totalEarnings: 0,
      joinDate: '2025-02-15',
      profileImage: 'https://i.pravatar.cc/150?img=60',
    ),
  ];

  static List<MockPartner> get activePartners =>
      allPartners.where((p) => p.status == 'active').toList();

  static List<MockPartner> get pendingPartners =>
      allPartners.where((p) => p.status == 'pending').toList();
}
