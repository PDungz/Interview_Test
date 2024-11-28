import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Duration duration = const Duration();
  Timer? timer;
  bool isRunning = false;

  // Hàm thêm thời gian
  void _addTime() {
    const addMilliseconds = 100; // Tăng thêm 100ms mỗi lần cập nhật
    setState(() {
      final milliseconds = duration.inMilliseconds + addMilliseconds;
      duration = Duration(milliseconds: milliseconds);
    });
  }

  // Bắt đầu đếm giờ
  void startWatch() {
    if (isRunning) return; // Ngăn chặn việc khởi động nhiều timer cùng lúc
    setState(() => isRunning = true);
    timer =
        Timer.periodic(const Duration(milliseconds: 100), (_) => _addTime());
  }

  // Dừng đếm giờ
  void stopWatch() {
    if (timer != null) {
      timer?.cancel();
      setState(() => isRunning = false);
    }
  }

  // Đặt lại thời gian về 0
  void resetWatch() {
    stopWatch(); // Dừng nếu đang chạy
    setState(() => duration = const Duration());
  }

  // Hủy timer khi widget bị xóa
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) =>
        n.toString().padLeft(2, '0'); // Thêm số 0 ở đầu nếu cần
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(
        duration.inMilliseconds.remainder(1000) ~/ 10); // Hiển thị centisecond

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Stop watch'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$hours : $minutes : $seconds : $milliseconds',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startWatch,
                  child: const Text("Start"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: stopWatch,
                  child: const Text("Stop"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: resetWatch,
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
