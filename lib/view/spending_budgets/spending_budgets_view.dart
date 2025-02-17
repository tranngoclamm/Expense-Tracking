import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';

import 'dart:ui' as ui;

// Để định dạng tháng
import 'dart:math' as math;

const List<String> chartType = <String>['Chi phí', 'Thu nhập'];
double totalAmount = 2600000; // Tổng số tiền ví dụ

String selectTab = 'month'; // Biến để lưu trạng thái của nút được chọn

List<Map<String, dynamic>> items = [
  {'name': 'Mua sắm', 'percentage': 46.15},
  {'name': 'Điện thoại', 'percentage': 19.23},
  {'name': 'Sắc đẹp', 'percentage': 19.23},
  {'name': 'Giáo dục', 'percentage': 7.69},
  {'name': 'Khác', 'percentage': 7.69},
];
List<Color> colors = [
  TColor.yellowChart,
  TColor.blueChart,
  TColor.redChart,
  TColor.greenblueChart,
  TColor.greenChart,
];
List budgetArr = [
  {
    "name": "Mua sắm",
    "icon": "assets/img/auto_&_transport.png",
    "spend_amount": "1200000",
    "total_budget": "400",
    "left_amount": "250.01",
    "color": TColor.secondaryG
  },
  {
    "name": "Điện thoại",
    "icon": "assets/img/entertainment.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "300.01",
    "color": TColor.secondary50
  },
  {
    "name": "Sắc đẹp",
    "icon": "assets/img/security.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "250.01",
    "color": TColor.primary10
  },
  {
    "name": "Giáo dục",
    "icon": "assets/img/auto_&_transport.png",
    "spend_amount": "1200000",
    "total_budget": "400",
    "left_amount": "250.01",
    "color": TColor.secondaryG
  },
  {
    "name": "Khác",
    "icon": "assets/img/entertainment.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "300.01",
    "color": TColor.secondary50
  },
  {
    "name": "Sắc đẹp",
    "icon": "assets/img/security.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "250.01",
    "color": TColor.primary10
  },
  {
    "name": "Mua sắm",
    "icon": "assets/img/auto_&_transport.png",
    "spend_amount": "1200000",
    "total_budget": "400",
    "left_amount": "250.01",
    "color": TColor.secondaryG
  },
  {
    "name": "Điện thoại",
    "icon": "assets/img/entertainment.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "300.01",
    "color": TColor.secondary50
  },
  {
    "name": "Sắc đẹp",
    "icon": "assets/img/security.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "250.01",
    "color": TColor.primary10
  },
  {
    "name": "Mua sắm",
    "icon": "assets/img/auto_&_transport.png",
    "spend_amount": "1200000",
    "total_budget": "400",
    "left_amount": "250.01",
    "color": TColor.secondaryG
  },
  {
    "name": "Điện thoại",
    "icon": "assets/img/entertainment.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "300.01",
    "color": TColor.secondary50
  },
  {
    "name": "Sắc đẹp",
    "icon": "assets/img/security.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "250.01",
    "color": TColor.primary10
  },
  {
    "name": "Mua sắm",
    "icon": "assets/img/auto_&_transport.png",
    "spend_amount": "1200000",
    "total_budget": "400",
    "left_amount": "250.01",
    "color": TColor.secondaryG
  },
  {
    "name": "Điện thoại",
    "icon": "assets/img/entertainment.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "300.01",
    "color": TColor.secondary50
  },
  {
    "name": "Sắc đẹp",
    "icon": "assets/img/security.png",
    "spend_amount": "500000",
    "total_budget": "600",
    "left_amount": "250.01",
    "color": TColor.primary10
  },
];
// Hàm lấy màu cho biểu đồ
Color _getColorForIndex(int index) {
  List<Color> colors = [
    TColor.yellowChart,
    TColor.blueChart,
    TColor.redChart,
    TColor.greenblueChart,
    TColor.greenChart,
  ];
  return colors[index % colors.length];
}

//dropdown_menu
class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = chartType.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.35, // Chiều rộng là 0.3 chiều rộng màn hình
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none, // Loại bỏ viền
          filled: true, // Tùy chọn có thể đổ màu nền nếu cần
          fillColor: Colors.transparent, // Có thể thay đổi màu nền
        ),
        value: dropdownValue,
        elevation: 15,
        style: const TextStyle(
          fontFamily: 'Poppins-Bold',
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 19,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: chartType.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

//tabbar_char
class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> _months; // Danh sách tháng
  @override
  void initState() {
    super.initState();
    _months = _generateMonths(); // Tạo danh sách tháng
    _tabController = TabController(
      length: _months.length,
      vsync: this,
      initialIndex:
          _months.indexOf('Tháng này'), // Chọn tháng hiện tại mặc định
    );
  }

  // Hàm tạo danh sách các tháng từ quá khứ đến hiện tại
  List<String> _generateMonths() {
    DateTime now = DateTime.now();
    DateTime start =
        DateTime(now.year - 1, now.month); // Bắt đầu từ tháng của năm ngoái
    List<String> months = [];

    // Danh sách các tháng bằng tiếng Việt
    List<String> vietnameseMonths = [
      'Thg 1',
      'Thg 2',
      'Thg 3',
      'Thg 4',
      'Thg 5',
      'Thg 6',
      'Thg 7',
      'Thg 8',
      'Thg 9',
      'Thg 10',
      'Thg 11',
      'Thg 12'
    ];

    while (!start.isAfter(now)) {
      // Lấy chỉ số tháng (0-11) và định dạng tháng theo tiếng Việt
      String monthString = vietnameseMonths[start.month - 1];
      String formattedMonth = '$monthString ${start.year}';
      if (start.year == now.year && start.month == now.month) {
        formattedMonth = 'Tháng này'; // Tháng hiện tại
      } else if (start.year == now.year && start.month == now.month - 1) {
        formattedMonth = 'Tháng trước'; // Tháng trước
      }
      months.add(formattedMonth); // Thêm tháng vào danh sách
      start = DateTime(start.year, start.month + 1); // Thêm từng tháng
    }

    return months;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white, // Màu nền của TabBar nếu cần
            child: TabBar(
              isScrollable: true, // Cho phép kéo ngang
              controller: _tabController,
              tabs: _months.map((month) {
                return Tab(
                  text: month, // Hiển thị tên tháng
                );
              }).toList(),
              indicatorWeight: 3, // Độ dày của thanh chọn
              indicatorColor: TColor.yellowHeader, // Màu underline
              labelColor: Colors.black, // Màu chữ khi được chọn
              unselectedLabelColor: Colors.grey, // Màu chữ khi không được chọn
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _months.map((month) {
                return _buildTabContent(month); // Nội dung của từng tab
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm xây dựng nội dung của từng tab
  Widget _buildTabContent(String month) {
    return Container(
      color: Colors.white, // Nền màu trắng
      padding: const EdgeInsets.only(
        top: 20.0, // Khoảng cách từ trên cùng
        right: 20,
        left: 10,
      ), // Khoảng cách từ các cạnh
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Để phần danh sách căn lên top
        children: [
          // Biểu đồ hình tròn
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 150, // Kích thước biểu đồ
                height: 150,
                child: CustomPaint(
                  painter: IncomePieChart(), // Vẽ biểu đồ
                ),
              ),
            ),
          ),
          // Danh sách khoản thu
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0), // Khoảng cách từ bên trái
              child: ListView.builder(
                itemCount: items.length, // Số khoản thu giả định
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.3), // Khoảng cách giữa các khoản thu
                    child: Row(
                      children: [
                        // Cột hình tròn màu sắc
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getColorForIndex(
                                index), // Màu tương ứng với biểu đồ
                          ),
                        ),
                        const SizedBox(
                            width: 8), // Khoảng cách giữa cột 1 và cột 2
                        // Cột tên khoản thu
                        Expanded(
                          child:
                              Text(item['name']), // Tên khoản thu từ danh sách
                        ),
                        // Cột % khoản thu
                        Text(
                            '${item['percentage']}%'), // % khoản thu từ danh sách
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// vẽ biểu đồ hình tròn
class IncomePieChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 30; // Độ dày của các phân đoạn
    double gap = 2; // Khoảng cách giữa các phân đoạn
    double radius = size.width / 2;
    double innerRadius = radius - strokeWidth; // Độ dày của lỗ rỗng ở giữa
    double startAngle = -math.pi / 2; // Bắt đầu từ góc 90 độ trên trục dọc

    double totalPercentage =
        items.fold(0, (sum, item) => sum + item['percentage']);
    if (totalPercentage == 0) return; // Tránh lỗi nếu tổng phần trăm bằng 0

    List<double> angles = [
      90,
      70,
      60,
      80,
      60
    ]; // Các góc tương ứng % từng khoản thu

    Paint paint = Paint()
      ..style =
          PaintingStyle.fill; // Đặt kiểu vẽ là fill để có màu sắc bên trong

    // Vẽ các phân đoạn với khoảng trống
    for (int i = 0; i < angles.length; i++) {
      double percentage = items[i]['percentage'];
      double sweepAngle = (percentage / totalPercentage) * 2 * math.pi;

      paint.color = _getColorForIndex(i);
      // Vẽ phân đoạn
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle - (gap * math.pi / 180), // Thay đổi góc để có khoảng trống
        true,
        paint,
      );

      // Cập nhật góc bắt đầu cho phân đoạn tiếp theo
      startAngle += sweepAngle - (gap * math.pi / 180) + (gap * math.pi / 180);
    }

    // Vẽ đường phân cách giữa các phân đoạn
    Paint borderPaint = Paint()
      ..color = Colors.white // Màu của đường phân cách
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3; // Độ dày của đường phân cách

    startAngle = -math.pi / 2; // Bắt đầu lại từ góc 90 độ

    for (int i = 0; i < angles.length; i++) {
      double sweepAngle = angles[i] * math.pi / 180;

      // Vẽ đường phân cách
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle,
        false,
        borderPaint,
      );

      // Cập nhật góc bắt đầu cho phân đoạn tiếp theo
      startAngle += sweepAngle + (gap * math.pi / 180);
    }

    // Vẽ phần lỗ rỗng ở giữa
    Paint holePaint = Paint()
      ..color = Colors.white // Màu của lỗ rỗng
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), innerRadius, holePaint);
    // Định dạng và vẽ tổng số tiền
    String formattedAmount = _formatAmount(totalAmount);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: formattedAmount,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12, // Kích thước chữ
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr, // Sử dụng TextDirection từ dart:ui
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    Offset textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  // Hàm định dạng số tiền
  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '+${(amount / 1000000).toStringAsFixed(1)} triệu';
    } else if (amount >= 1000) {
      return '+${(amount / 1000).toStringAsFixed(1)} trăm';
    } else {
      return '+${amount.toStringAsFixed(0)}';
    }
  }
}

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({super.key});

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
}

class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        children: [
          // Nội dung cuộn bên dưới
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 +
                      20, // Dành không gian cho header
                ),
                ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: budgetArr.length,
                    itemBuilder: (context, index) {
                      var bObj = budgetArr[index] as Map? ?? {};

                      return BudgetsRow(
                        bObj: bObj,
                        onPressed: () {},
                      );
                    }),
              ],
            ),
          ),

          // Header cố định
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: TColor.yellowHeader,
              // height: MediaQuery.of(context).size.height * 0.167,
              child: Column(
                children: [
                  const SizedBox(
                      height: 40), // Khoảng cách giữa dropdown và các button
                  const DropdownMenuExample(), // DropdownMenuExample ở trên
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20), // Thêm padding bottom 20px
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectTab = 'month'; // Chọn nút "Tháng"
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectTab == 'month'
                                ? const Color.fromARGB(
                                    255, 5, 5, 5) // Nền đen khi được chọn
                                : const Color(
                                    0xffFFDA47), // Nền trong suốt khi không được chọn
                            side: BorderSide(
                              color: selectTab == 'month'
                                  ? const Color.fromARGB(255, 5, 5, 5)
                                  : Colors.black,
                              width: 0.5,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7.0),
                                bottomLeft: Radius.circular(7.0),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 17.0,
                              horizontal: 65.0,
                            ),
                          ),
                          child: Text(
                            'Tháng',
                            style: TextStyle(
                              color: selectTab == 'month'
                                  ? const Color.fromARGB(255, 254, 221,
                                      85) // Chữ vàng khi được chọn
                                  : Colors.black, // Chữ đen khi không được chọn
                            ),
                          ),
                        ),
                        const SizedBox(width: 0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectTab = 'year'; // Chọn nút "Năm"
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectTab == 'year'
                                ? const Color.fromARGB(
                                    255, 5, 5, 5) // Nền đen khi được chọn
                                : const Color(
                                    0xffFFDA47), // Nền trong suốt khi không được chọn
                            side: BorderSide(
                              color: selectTab == 'year'
                                  ? const Color.fromARGB(255, 5, 5, 5)
                                  : Colors.black,
                              width: 0.5,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7.0),
                                bottomRight: Radius.circular(7.0),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 17.0,
                              horizontal: 65.0,
                            ),
                          ),
                          child: Text(
                            'Năm',
                            style: TextStyle(
                              color: selectTab == 'year'
                                  ? const Color.fromARGB(255, 254, 221,
                                      85) // Chữ vàng khi được chọn
                                  : Colors.black, // Chữ đen khi không được chọn
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //chart
                  SizedBox(
                    height: media.height * 0.34, // Chiều cao 37.5% màn hình
                    child: const TabBarExample(),
                  ),
                  Container(
                    width: media.width,
                    height: 1.5, // Độ dày của đường underline
                    color: const Color(0xffe3e3e3), // Màu của đường underline
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//UI data
class BudgetsRow extends StatelessWidget {
  final Map bObj;
  final Function onPressed;

  const BudgetsRow({required this.bObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    int index = budgetArr.indexOf(bObj);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hàng 1: Icon, phần trăm chi tiêu, và số tiền đã chi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cột 1: Icon bọc trong hình tròn với màu nền tương ứng
                  Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors[index %
                          colors.length], // Màu nền lấy từ danh sách colors
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(bObj['icon']), // Icon
                    ),
                  ),
                  const SizedBox(width: 10), // Khoảng cách giữa icon và cột 2

                  // Cột 2: Tên khoản thu và % khoản thu đã chi tiêu
                  Expanded(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Căn giữa hai phần tử
                      children: [
                        // Tên khoản thu
                        Text(
                          bObj['name'], // Hiển thị tên khoản thu
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        // Phần trăm khoản thu đã chi tiêu
                        Text(
                          '${_getPercentage(bObj)}%', // Hiển thị % khoản thu
                          style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cột 3: Số tiền đã chi tiêu (spend_amount)
                  Text(
                    formatNumber(bObj['spend_amount']), // Số tiền đã chi tiêu
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: 0), // Khoảng cách giữa hàng 1 và đường màu vàng

              // Hàng 2: Đường màu vàng hiển thị % chi tiêu, bắt đầu từ cột 2
              Row(
                children: [
                  // Đường màu vàng đại diện cho phần trăm chi tiêu, bắt đầu từ cột 2
                  Container(
                    child: Transform.translate(
                      offset: const Offset(0, -10), // Dịch chuyển lên trên 10px
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 3, top: 2), // Khoảng cách từ bên trái
                        child: Container(
                          height: 7,
                          margin: const EdgeInsets.only(
                              left: 40), // Bắt đầu từ cột 2
                          decoration: BoxDecoration(
                            color:
                                TColor.yellowHeader, // Màu vàng của đường line
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // Chiều dài đường line dựa trên % chi tiêu
                          width: MediaQuery.of(context).size.width *
                              _getPercentageAsDouble(bObj) /
                              100,
                        ), // Độ dày của đường phân cách
                      ),
                    ),
                  ),

                  // const SizedBox(width: 5), // Khoảng cách nhỏ giữa đường line và mép phải
                ],
              ),
            ],
          ),
        ),

        // Đường kẻ xám phân cách giữa các hàng
        Transform.translate(
          offset: const Offset(0, -8), // Dịch chuyển lên trên 10px
          child: const Padding(
            padding: EdgeInsets.only(
              top: 0,
              left: 30.0,
              right: 5,
            ), // Khoảng cách từ bên trái
            child: Divider(
              color: Color.fromARGB(255, 242, 242, 242),
              thickness: 0.5, // Độ dày của đường phân cách
            ),
          ),
        )
      ],
    );
  }

  // Hàm tính phần trăm chi tiêu
  String _getPercentage(Map bObj) {
    double spendAmount = double.parse(bObj['spend_amount']);
    return ((spendAmount / totalAmount) * 100).toStringAsFixed(2);
  }

  // Hàm trả về giá trị phần trăm ở dạng double
  double _getPercentageAsDouble(Map bObj) {
    double spendAmount = double.parse(bObj['spend_amount']);
    return (spendAmount / totalAmount) * 100;
  }
}

String formatNumber(String number) {
  // Convert the string to an integer
  int value = int.tryParse(number) ?? 0;

  // Format the number with periods as thousands separators
  return value.toString().replaceAll(RegExp(r'(?<=\d)(?=(\d{3})+(\.|$))'), '.');
}
