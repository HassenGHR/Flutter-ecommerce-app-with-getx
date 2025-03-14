import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExploreTabSkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSearchSkeleton(context),
              SizedBox(height: 10),

              // Skeleton for Offer Carousel
              _buildOfferCarouselSkeleton(context),

              // Offer Indicator Skeleton
              _buildOfferIndicatorSkeleton(),

              SizedBox(height: 16),

              // Categories Section Skeleton
              _buildCategoriesSkeleton(theme),

              SizedBox(height: 16),

              // Products Section Header Skeleton
              _buildSectionHeaderSkeleton(theme),

              SizedBox(height: 8),

              // Products Grid/List Skeleton
              _buildProductsSkeleton(theme)
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildSearchSkeleton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 15.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 250,
              height: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCarouselSkeleton(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildOfferIndicatorSkeleton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoriesSkeleton(ThemeData theme) {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildSingleCategorySkeleton();
        },
      ),
    );
  }

  Widget _buildSingleCategorySkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 120,
        height: 60,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionHeaderSkeleton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 24,
              color: Colors.white,
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSkeleton(ThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildSingleProductSkeleton();
      },
    );
  }

  Widget _buildSingleProductSkeleton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Skeleton
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),

              // Product Info Skeleton
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name Skeleton
                    Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),

                    // Product Category Skeleton
                    Container(
                      height: 15,
                      width: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),

                    // Price and Cart Button Skeleton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 20,
                          width: 80,
                          color: Colors.white,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Availability Skeleton
                    Container(
                      height: 15,
                      width: 120,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
