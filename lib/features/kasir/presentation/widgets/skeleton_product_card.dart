import 'package:flutter/material.dart';
import 'package:login_biometrics_app/core/components/loader/shimmer_loader.dart';
import 'package:login_biometrics_app/core/components/loader/title_placeholder.dart';

class SkeletonProductCard extends StatelessWidget {
  const SkeletonProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          // --- Gambar produk + badge stok menumpuk di pojok ---
          Flexible(
            flex: 3,
            child: ShimmerLoader(
              child: Container(height: 200, width: double.infinity, color: Colors.white),
            ),
          ),
          // --- Info produk ---
          const Flexible(
            flex: 2,
            child: Padding(
              padding: .fromLTRB(10, 8, 10, 10),
              child: ShimmerLoader(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: .start,
                  children: [
                    TitlePlaceholder(words: 2),
                    TitlePlaceholder(words: 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}