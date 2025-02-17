import 'package:flutter/material.dart';
import 'package:trackizer/model/user-model.dart';
import 'package:trackizer/model/user.dart';
import 'package:trackizer/service/user.dart';
import 'package:provider/provider.dart';
import 'package:trackizer/view/user_detail/UserDetailScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Tải thông tin người dùng khi khởi tạo
  }

  Future<void> _loadUserInfo() async {
    final user = Provider.of<AppUser?>(context, listen: false);
    final uid = user?.uid;

    // Gọi hàm lấy thông tin người dùng
    userModel = await UserService().getUserByUid(uid!);
    setState(() {}); // Cập nhật lại trạng thái để làm mới giao diện
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _loadUserInfo(); // Khi quay trở lại, gọi lại hàm để load lại dữ liệu
        return true; // Cho phép quay lại
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 254, 221, 85),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: userModel == null
            ? const Center(
                child: CircularProgressIndicator()) // Hiển thị vòng tròn tải
            : Column(
                children: [
                  // Phần header thông tin người dùng
                  Container(
                    color: const Color.fromARGB(255, 254, 221, 85),
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () async {
                        // Điều hướng đến màn hình chi tiết người dùng
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(
                                userModel:
                                    userModel!), // Truyền userModel vào màn hình chi tiết
                          ),
                        );
                        _loadUserInfo(); // Load lại dữ liệu khi quay lại từ UserDetailScreen
                      },
                      child: Row(
                        children: [
                          // Ảnh đại diện
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              userModel?.avatar?.replaceAll('\\', '/') ??
                                  'assets/img/avatar.png', // Đường dẫn ảnh đại diện
                            ),
                            radius: 30,
                          ),
                          const SizedBox(width: 16),
                          // Thông tin tên và ID người dùng
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel?.name ?? 'Chưa có tên',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'ID: ${userModel?.uid ?? 'Chưa có ID'}',
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Danh sách các mục
                  Expanded(
                    child: ListView(
                      children: [
                        buildMenuItem(
                          icon: Icons.star,
                          text: 'Quản lý tài khoản',
                          iconColor: Colors.orange,
                        ),
                        buildMenuItem(
                          icon: Icons.thumb_up_alt_outlined,
                          text: 'Giới thiệu cho bạn bè',
                          iconColor: Colors.yellow[700]!,
                        ),
                        buildMenuItem(
                          icon: Icons.rate_review_outlined,
                          text: 'Đánh giá ứng dụng',
                          iconColor: Colors.orange,
                        ),
                        buildMenuItem(
                          icon: Icons.block,
                          text: 'Chặn quảng cáo',
                          iconColor: Colors.orange,
                        ),
                        buildMenuItem(
                          icon: Icons.settings_outlined,
                          text: 'Cài đặt',
                          iconColor: Colors.orange,
                        ),
                        const Divider(), // Thêm ngăn cách giữa các mục
                        // Mục Đăng xuất
                        buildMenuItem(
                          icon: Icons.logout,
                          text: 'Đăng xuất',
                          iconColor: Colors.red,
                        ),
                        // Thêm mục mới ở đây
                        buildMenuItem(
                          icon: Icons.delete_forever,
                          text: 'Xóa tài khoản',
                          iconColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  // Thanh điều hướng dưới
                  BottomNavigationBar(
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.yellow[700],
                    unselectedItemColor: Colors.black54,
                    currentIndex: 4,
                    onTap: (index) {},
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Trang chủ',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.bar_chart),
                        label: 'Biểu đồ',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add_circle,
                            size: 40, color: Colors.yellow[700]!),
                        label: '',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.report),
                        label: 'Báo cáo',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Tôi',
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  // Hàm để xây dựng một mục trong danh sách
  Widget buildMenuItem({
    required IconData icon,
    required String text,
    required Color iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      onTap: () {
        // Thêm chức năng khi nhấn vào mục
        if (text == 'Đăng xuất') {
          // Xử lý đăng xuất
        } else if (text == 'Xóa tài khoản') {
          // Xử lý xóa tài khoản
        }
      },
    );
  }
}
