class EmiPlan {
  final String id;
  final int tenureMonths;
  final double monthlyEmi;
  final double interestRate;
  final double processingFee;

  EmiPlan({
    required this.id,
    required this.tenureMonths,
    required this.monthlyEmi,
    this.interestRate = 0.0, // For NO-COST EMI
    this.processingFee = 0.0,
  });

  factory EmiPlan.fromJson(Map<String, dynamic> json) {
    return EmiPlan(
      id: json['id'],
      tenureMonths: json['tenureMonths'],
      monthlyEmi: (json['monthlyEmi'] as num).toDouble(),
    );
  }

  double get totalPayable => (monthlyEmi * tenureMonths) + processingFee;
}
