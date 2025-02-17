import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackizer/model/transaction.dart';
import 'package:intl/intl.dart';

import '../common/color_extension.dart';

class TransactionService {
  final CollectionReference _transactionCollection =
  FirebaseFirestore.instance.collection('transactions');

  // Thêm mới Transaction
  Future<void> addTransaction(Transactions transaction) async {
    try {
      DocumentReference docRef = _transactionCollection.doc();
      await docRef.set(transaction.copyWith(id: docRef.id).toJson());
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  // Cập nhật Transaction
  Future<void> updateTransaction(Transactions transaction) async {
    try {
      await _transactionCollection
          .doc(transaction.id) // Sử dụng `id` làm document ID
          .update(transaction.toJson());
    } catch (e) {
      print('Error updating transaction: $e');
    }
  }

  // Xóa Transaction
  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionCollection
          .doc(id)
          .delete(); // Sử dụng `id` làm document ID
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }

  Stream<List<Transactions>> getTransactions(String uid, DateTime month) {
    DateTime startOfMonth = DateTime(month.year, month.month, 1);
    DateTime endOfMonth = DateTime(month.year, month.month + 1, 0);

    print("Fetching transactions for UID: $uid, Month: $month");

    return _transactionCollection
        .where('uid', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .snapshots()
        .map((snapshot) {
      print("Fetched ${snapshot.docs.length} transactions");
      return snapshot.docs
          .map((doc) {
        print("Transaction Data: ${doc.data()}");
        return Transactions.fromJson(doc.data() as Map<String, dynamic>);
      })
          .toList();
    });
  }

  String formatCurrency(int amount) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'vi_VN', // Định dạng cho Việt Nam
      symbol: '', // Không cần ký hiệu "₫"
      decimalDigits: 0, // Không có số lẻ
    );
    return currencyFormat.format(amount);
  }

  Stream<Map<String, dynamic>> getMonthlySummary(String uid, DateTime month) {
    DateTime startOfMonth = DateTime(month.year, month.month, 1);
    DateTime endOfMonth = DateTime(month.year, month.month + 1, 0);

    print("Fetching monthly summary for UID: $uid, Month: $month");

    var transactionsStream = _transactionCollection
        .where('uid', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .snapshots()
        .map((snapshot) {
      print("Fetched ${snapshot.docs.length} transactions for summary");
      return snapshot.docs
          .map((doc) =>
          Transactions.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });

    return transactionsStream.map((transactions) {
      int totalExpenses = 0;
      int totalIncome = 0;

      for (var transaction in transactions) {
        print("Processing transaction: ${transaction.toJson()}");
        if (transaction.category.type == 'Expense') {
          totalExpenses += transaction.amount.toInt();
        } else if (transaction.category.type == 'Income') {
          totalIncome += transaction.amount.toInt();
        }
      }

      print("Total Expenses: $totalExpenses, Total Income: $totalIncome");

      return {
        'transactions': transactions,
        'totalExpenses': formatCurrency(totalExpenses),
        'totalIncome': formatCurrency(totalIncome),
        'balance': formatCurrency(totalIncome - totalExpenses)
      };
    });
  }

  Stream<Map<String, dynamic>> getCategorySummary(String uid, DateTime month) {
    DateTime startOfMonth = DateTime(month.year, month.month, 1);
    DateTime endOfMonth = DateTime(month.year, month.month + 1, 0);

    print(
        "Fetching transactions for UID: $uid from $startOfMonth to $endOfMonth");

    // Lấy các transaction theo uid và tháng
    var transactionsStream = _transactionCollection
        .where('uid', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .snapshots()
        .map((snapshot) {
      print("Fetched ${snapshot.docs.length} transactions");
      return snapshot.docs
          .map((doc) {
        print("Transaction Data: ${doc.data()}");
        return Transactions.fromJson(doc.data() as Map<String, dynamic>);
      })
          .toList();
    });

    return transactionsStream.map((transactions) {
      Map<String, int> categoryTotals = {};
      int totalExpenses = 0;
      int totalIncome = 0;

      for (var transaction in transactions) {
        String category = transaction.category.name;
        int amount = transaction.amount.toInt();

        if (transaction.category.type == 'Expense') {
          totalExpenses += amount;
        } else if (transaction.category.type == 'Income') {
          totalIncome += amount;
        }

        if (categoryTotals.containsKey(category)) {
          categoryTotals[category] = categoryTotals[category]! + amount;
        } else {
          categoryTotals[category] = amount;
        }
      }

      print("Total Expenses: $totalExpenses, Total Income: $totalIncome");
      print("Category Totals: $categoryTotals");

      // Sắp xếp các category theo số tiền giảm dần
      List<MapEntry<String, int>> sortedCategories = categoryTotals.entries
          .toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // Lấy ra 5 loại category có số tiền lớn nhất
      List<MapEntry<String, int>> top5Categories = sortedCategories.take(5)
          .toList();

      // Gộp các category còn lại thành một mục "Other"
      int othersTotal = sortedCategories.skip(5).fold(
          0, (sum, item) => sum + item.value);

      // Chuẩn bị dữ liệu cho biểu đồ tròn
      Map<String, dynamic> chartData = {
        'totalExpenses': formatCurrency(totalExpenses),
        'totalIncome': formatCurrency(totalIncome),
        'categories': [
          ...top5Categories.map((entry) =>
              MapEntry(entry.key, formatCurrency(entry.value))),
          if (othersTotal > 0) MapEntry('Other', formatCurrency(othersTotal)),
          // Gộp các loại còn lại
        ]
      };

      print("Final Chart Data: $chartData");

      return chartData;
    });
  }

  // trang biểu đồ
  Stream<Map<String, dynamic>> getTransactionSummary(String uid, DateTime month) {
    DateTime startOfMonth = DateTime(month.year, month.month, 1);
    DateTime endOfMonth = DateTime(month.year, month.month + 1, 0);

    print("Fetching transaction summary for UID: $uid, Month: $month");

    var transactionsStream = _transactionCollection
        .where('uid', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .snapshots()
        .map((snapshot) {
      print("Fetched ${snapshot.docs.length} transactions for summary");
      return snapshot.docs
          .map((doc) => Transactions.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });

    return transactionsStream.map((transactions) {
      List<Map<String, dynamic>> budgetSummary = [];
      int totalExpenses = 0;
      int totalIncome = 0;

      // Tính toán tổng chi phí và thu nhập
      for (var transaction in transactions) {
        int amount = transaction.amount.toInt();
        if (transaction.category.type == 'Expense') {
          totalExpenses += amount;
        } else if (transaction.category.type == 'Income') {
          totalIncome += amount;
        }

        // Tạo danh sách chi tiết các mục chi tiêu
        budgetSummary.add({
          "name": transaction.category.name,
          "spend_amount": formatCurrency(amount),
          "total_budget": "400",  // Có thể thay bằng giá trị thực tế từ cơ sở dữ liệu
          "left_amount": formatCurrency(400 - amount),  // Tính toán số tiền còn lại
          "color": _getColorForCategory(transaction.category.name) // Gán màu theo danh mục
        });
      }

      // Tính toán số dư tài khoản
      int balance = totalIncome - totalExpenses;

      print("Total Expenses: $totalExpenses, Total Income: $totalIncome");

      return {
        'transactions': transactions,
        'totalExpenses': formatCurrency(totalExpenses),
        'totalIncome': formatCurrency(totalIncome),
        'balance': formatCurrency(balance),
        'budgetSummary': budgetSummary  // Trả về danh sách chi tiêu chi tiết
      };
    });
  }

// Hàm lấy màu cho từng loại danh mục
  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Mua sắm':
        return TColor.secondaryG;
      case 'Điện thoại':
        return TColor.secondary50;
      case 'Sắc đẹp':
        return TColor.primary10;
      case 'Giáo dục':
        return TColor.greenblueChart;
      default:
        return TColor.greenChart;
    }
  }


}


