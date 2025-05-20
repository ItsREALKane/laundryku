import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundryku/data/model/laundry.dart';

class OrderItem {
  final int id;
  final String name;
  final String status;
  final String orderDate;
  final String phone;
  final String alamat;
  final String infoPesanan;
  final int total;
  final String jasa;
  final String pengantaran;
  final String img;

  OrderItem(
      {required this.id,
      required this.name,
      required this.status,
      required this.orderDate,
      required this.phone,
      required this.alamat,
      required this.infoPesanan,
      required this.total,
      required this.jasa,
      required this.pengantaran,
      required this.img});
}

class OrderController extends GetxController {
  var orders = <OrderItem>[].obs;
  var isLoading = false.obs;
  var isNewestFirst = true.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  void resetDateRange() {
    startDate.value = null;
    endDate.value = null;
  }

  var selectedStatus = 'All'.obs;

  List<OrderItem> get filteredOrders {
    List<OrderItem> result = orders;

    if (selectedStatus.value != 'All') {
      result = result.where((o) => o.status == selectedStatus.value).toList();
    }

    if (startDate.value != null && endDate.value != null) {
      result = result.where((o) {
        final orderDate = DateTime.tryParse(o.orderDate);
        return orderDate != null &&
            orderDate
                .isAfter(startDate.value!.subtract(const Duration(days: 1))) &&
            orderDate.isBefore(endDate.value!.add(const Duration(days: 1)));
      }).toList();
    }

    result.sort((a, b) {
      final aDate = DateTime.tryParse(a.orderDate);
      final bDate = DateTime.tryParse(b.orderDate);
      if (aDate == null || bDate == null) return 0;
      return isNewestFirst.value
          ? bDate.compareTo(aDate)
          : aDate.compareTo(bDate);
    });

    return result;
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        Get.snackbar("Error", "User belum login");
        return;
      }

      final orderRes =
          await http.get(Uri.parse('https://laundryku.rplrus.com/api/pesanan'));

      final laundryRes =
          await http.get(Uri.parse('https://laundryku.rplrus.com/api/laundry'));

      if (orderRes.statusCode == 200 && laundryRes.statusCode == 200) {
        final List orderData = jsonDecode(orderRes.body);
        final List laundryData = jsonDecode(laundryRes.body);

        final Map<int, Laundry> laundryMap = {
          for (var l in laundryData)
            int.parse(l['id'].toString()): Laundry.fromJson(l)
        };

        final filtered =
            orderData.where((item) => item['id_user'] == userId).toList();

        orders.value = filtered.map((order) {
          final laundryId = int.parse(order['id_laundry'].toString());
          final laundry = laundryMap[laundryId];
          final laundryName = laundry?.nama ?? 'Laundry Tidak Diketahui';
          final jasa = laundry?.jasa ?? 'Jasa Tidak Diketahui';
          final pengantaran =
              laundry?.pengantaran ?? 'Pengantaran Tidak Diketahui';

          final img = laundry?.img ?? 'assets/image/coba.jpeg';

          return OrderItem(
            id: order['id'],
            name: laundryName,
            status: order['status'],
            orderDate: order['tanggal_pesanan'],
            phone: order['user']?['phone'] ?? 'Tidak Diketahui',
            alamat: order['alamat'] ?? 'Alamat Tidak Diketahui',
            infoPesanan:
                order['info_pesanan'] ?? 'Info Pesanan Belum Diketahui',
            total: int.tryParse(
                    order['total_harga'].toString().split('.').first) ??
                0,
            jasa: jasa,
            pengantaran: pengantaran,
            img: img,
          );
        }).toList();
      } else {
        Get.snackbar("Error", "Gagal mengambil data dari server");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
