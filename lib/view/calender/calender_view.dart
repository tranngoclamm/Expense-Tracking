import 'dart:math';
import 'package:trackizer/service/transation.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/model/user.dart';
import 'package:trackizer/service/transation.dart';
import 'package:trackizer/view/add_subscription/add_subscription_view.dart';
import 'package:trackizer/view/settings/settings_view.dart';
import '../../common_widget/subscription_cell.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  int selectTab = 0;
  CalendarAgendaController calendarAgendaControllerNotAppBar =
      CalendarAgendaController();
  late DateTime selectedDateNotAppBBar;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header với Tab bar
          Container(
            color: TColor.yellowHeader, // Màu vàng của header
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  "Báo cáo", // Tiêu đề chính
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nút "Phân tích"
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectTab =
                                0; // Khi nhấn vào nút này, cập nhật selectTab là 0
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectTab == 0
                              ? Colors.black
                              : TColor.yellowHeader, // Đổi màu khi được chọn
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.0),
                              bottomLeft: Radius.circular(7.0),
                            ),
                          ),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          'Phân tích',
                          style: TextStyle(
                            color: selectTab == 0
                                ? TColor.yellowHeader
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 0),

                    // Nút "Tài khoản"
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectTab =
                                1; // Khi nhấn vào nút này, cập nhật selectTab là 1
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectTab == 1
                              ? Colors.black
                              : TColor.yellowHeader, // Đổi màu khi được chọn
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7.0),
                              bottomRight: Radius.circular(7.0),
                            ),
                          ),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          'Tài khoản',
                          style: TextStyle(
                            color: selectTab == 1
                                ? TColor.yellowHeader
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Tạo khoảng cách

          // Hiển thị nội dung dựa trên giá trị của selectTab
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: selectTab == 0
                  ? _buildPhanTichContent() // Hiển thị nội dung của "Phân tích"
                  : _buildTaiKhoanContent(), // Hiển thị nội dung của "Tài khoản"
            ),
          ),
        ],
      ),
    );
  }

  // Nội dung khi tab "Phân tích" được chọn
  Widget _buildPhanTichContent() {
    final user = Provider.of<AppUser?>(context);
    final uid = user?.uid;
    DateTime currentMonth = DateTime.now();
    return Column(
      children: [
        StreamBuilder<Map<String, dynamic>>(
          stream: TransactionService().getMonthlySummary(uid!, currentMonth),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final totalExpenses = snapshot.data!['totalExpenses'] ?? 0;
              final totalIncome = snapshot.data!['totalIncome'] ?? 0;
              final balance = snapshot.data!['balance'] ?? 0;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Căn lề trái cho nội dung
                      children: [
                        // Tiêu đề và mũi tên điều hướng
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn đều các phần tử trong Row
                          children: [
                            Text(
                              "Thống kê hàng tháng",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold, // Chữ in đậm
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 16), // Icon mũi tên điều hướng
                          ],
                        ),
                        const SizedBox(
                            height:
                                10), // Khoảng cách giữa tiêu đề và nội dung bên dưới
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start, // Căn đều các phần tử
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Căn đều các phần tử
                              children: [
                                Text("Thg ${currentMonth.month}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Spacer(), // Khoảng trống giữa các mục để căn đều
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Chi phí",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text("${totalExpenses}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Số dư",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text("${balance}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Thu nhập",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text("${totalIncome}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ngân sách hàng tháng
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ngân sách hàng tháng",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: TColor.gray, width: 4),
                              ),
                              child: Center(
                                child: Text(
                                  "--",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Còn lại:",
                                        style: TextStyle(
                                            fontSize: 14, color: TColor.gray),
                                      ),
                                      Text(
                                        "-${totalExpenses}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ngân sách:",
                                        style: TextStyle(
                                            fontSize: 14, color: TColor.gray),
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Chi phí:",
                                        style: TextStyle(
                                            fontSize: 14, color: TColor.gray),
                                      ),
                                      Text(
                                        "${totalExpenses}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Text("Đã có lỗi xảy ra");
          },
        ),
      ],
    );
  }

  Widget _buildTaiKhoanContent() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width *
              0.9, // Tăng chiều rộng của khối
          padding: const EdgeInsets.all(20), // Padding xung quanh nội dung
          decoration: BoxDecoration(
            color: TColor.yellowHeader, // Màu nền vàng cho phần khối chính
            borderRadius: BorderRadius.circular(12), // Bo góc các cạnh
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu bóng đổ nhẹ
                blurRadius: 6, // Độ mờ của bóng
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Căn đều các phần tử
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Giá trị ròng",
                        style: TextStyle(
                            fontSize: 14, color: TColor.gray), // Màu chữ xám
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "5.000",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tài sản",
                        style: TextStyle(
                            fontSize: 14, color: TColor.gray), // Màu chữ xám
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "154.320",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Nợ phải trả",
                        style: TextStyle(
                            fontSize: 14, color: TColor.gray), // Màu chữ xám
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "26.523",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20), // Khoảng cách giữa các khối

        // Khối "Thêm tài khoản" và "Quản lý tài khoản" với màu nền riêng
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 15), // Padding giữa các button
          color: const Color(0xFFF5F5F5), // Màu nền của khối này
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Căn đều hai nút
            children: [
              ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn vào "Thêm tài khoản"
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30), // Padding nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bo góc nút
                  ),
                  backgroundColor: TColor.white, // Nền trắng cho nút
                  side: BorderSide(
                    color: TColor.gray, // Đường viền xám
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'Thêm tài khoản',
                  style: TextStyle(
                    color: Colors.black, // Màu chữ đen
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn vào "Quản lý tài khoản"
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30), // Padding nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bo góc nút
                  ),
                  backgroundColor: TColor.white, // Nền trắng cho nút
                  side: BorderSide(
                    color: TColor.gray, // Đường viền xám
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'Quản lý tài khoản',
                  style: TextStyle(
                    color: Colors.black, // Màu chữ đen
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
