// ignore_for_file: one_member_abstracts
import 'package:domain/domain.dart';

/// Repository for handling customers
abstract class CustomerRepo {
  /// Fetch current customer
  Future<Customer> fetchMe();
}
