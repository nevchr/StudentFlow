import 'package:student_flow/core/money.dart';

enum AccountType { chequing, savings, creditCard }

final class Account {
  const Account({
    required this.id,
    required this.name,
    required this.institutionName,
    required this.mask,
    required this.type,
    required this.currentBalance,
    required this.availableBalance,
  });

  final String id;
  final String name;
  final String institutionName;
  final String mask;
  final AccountType type;
  final Money currentBalance;
  final Money availableBalance;
}
