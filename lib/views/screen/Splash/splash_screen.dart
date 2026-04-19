import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/splash_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _progress = Tween<double>(begin: 0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.find<SplashController>().jumpNextScreen();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.logo,
                  width: 150.w,
                  height: 150.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 28.h),
                Text(
                  'SalonSeat',
                  style: AppFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Premium Salon Marketplace',
                  textAlign: TextAlign.center,
                  style: AppFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 36.h),
                AnimatedBuilder(
                  animation: _progress,
                  builder: (context, _) => _SplashProgressBar(
                    value: _progress.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final barHeight = 8.h;
    final barWidth = 220.w;

    return Semantics(
      label: 'Loading',
      value: '${(value * 100).round()}%',
      child: SizedBox(
        width: barWidth,
        height: barHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(barHeight / 2),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: Colors.white),
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: value.clamp(0.0, 1.0),
                  heightFactor: 1,
                  child: const ColoredBox(color: AppColors.splashAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
