import 'package:flutter/material.dart';
import 'package:cristalyse/cristalyse.dart';
import '../theme/hux_colors.dart';

/// Chart types supported by HuxChart
enum HuxChartType {
  /// Line chart with connected data points
  line,
  
  /// Bar chart with rectangular bars
  bar,
}

/// Chart size variants
enum HuxChartSize {
  /// Small chart (200px height)
  small,
  
  /// Medium chart (300px height)
  medium,
  
  /// Large chart (400px height)
  large,
}

/// A customizable chart widget that wraps cristalyse with Hux UI styling
class HuxChart extends StatelessWidget {
  /// Creates a HuxChart widget.
  /// 
  /// The [data], [type], [xField], and [yField] parameters are required.
  const HuxChart({
    super.key,
    required this.data,
    required this.type,
    required this.xField,
    required this.yField,
    this.size = HuxChartSize.medium,
    this.colorField,
    this.title,
    this.subtitle,
    Color? primaryColor,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 800),
  }) : primaryColor = primaryColor ?? const Color(0xFF3B82F6);

  /// The data to display in the chart
  final List<Map<String, dynamic>> data;
  
  /// The type of chart to display
  final HuxChartType type;
  
  /// The size of the chart
  final HuxChartSize size;
  
  /// X-axis field name
  final String xField;
  
  /// Y-axis field name
  final String yField;
  
  /// Optional color field for grouping/coloring
  final String? colorField;
  
  /// Chart title
  final String? title;
  
  /// Chart subtitle
  final String? subtitle;
  
  /// Primary color for the chart
  final Color primaryColor;
  
  /// Whether to show animations
  final bool animated;
  
  /// Animation duration
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      height: _getChartHeight(),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? HuxColors.white20 : HuxColors.black20,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || subtitle != null) ...[
            _buildHeader(context),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: _buildChart(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? HuxColors.white : HuxColors.black,
            ),
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? HuxColors.white70 : HuxColors.black70,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    try {
      // Create custom theme based on current theme
      final customTheme = ChartTheme(
        backgroundColor: isDark ? HuxColors.black90 : HuxColors.white,
        primaryColor: isDark ? HuxColors.white : primaryColor,
        colorPalette: isDark 
          ? [HuxColors.white, HuxColors.white70, HuxColors.white60]
          : [primaryColor],
        plotBackgroundColor: isDark ? HuxColors.black90 : HuxColors.white,
        borderColor: Colors.transparent,
        gridColor: isDark ? HuxColors.white20 : HuxColors.black20,
        axisColor: isDark ? HuxColors.white30 : HuxColors.black30,
        gridWidth: 0.5,
        axisWidth: 1.0,
        pointSizeDefault: 4.0,
        pointSizeMin: 2.0,
        pointSizeMax: 8.0,
        axisTextStyle: TextStyle(
          fontSize: 12, 
          color: isDark ? HuxColors.white70 : HuxColors.black70,
        ),
        padding: const EdgeInsets.all(16),
      );

      // Build the base chart with custom theme
      var chart = CristalyseChart()
          .data(data)
          .mapping(
            x: xField,
            y: yField,
            color: colorField,
          )
          .theme(customTheme);

      // Add geometry based on chart type
      switch (type) {
        case HuxChartType.line:
          chart = chart
              .geomLine(
                strokeWidth: 3.0,
                alpha: 0.95,
              )
              .geomPoint(
                size: 8.0,
                alpha: 0.9,
              );
          break;
        case HuxChartType.bar:
          chart = chart.geomBar(width: 0.8);
          break;
      }

      // Add scales
      chart = chart
          .scaleXContinuous()
          .scaleYContinuous();

      // Add animation if enabled
      if (animated) {
        chart = chart.animate(
          duration: animationDuration,
          curve: Curves.easeInOutCubic,
        );
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: chart.build(),
      );
    } catch (e) {
      // Fallback UI if chart fails to build
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 48,
              color: Theme.of(context).brightness == Brightness.dark 
                  ? HuxColors.white40 
                  : HuxColors.black40,
            ),
            const SizedBox(height: 16),
            Text(
              'Chart Preview',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? HuxColors.white60 
                    : HuxColors.black60,
              ),
            ),
          ],
        ),
      );
    }
  }

  double _getChartHeight() {
    switch (size) {
      case HuxChartSize.small:
        return 200;
      case HuxChartSize.medium:
        return 300;
      case HuxChartSize.large:
        return 400;
    }
  }
}

/// Convenience constructors for common chart types
extension HuxChartConstructors on HuxChart {
  /// Creates a line chart
  static HuxChart line({
    Key? key,
    required List<Map<String, dynamic>> data,
    required String xField,
    required String yField,
    String? colorField,
    String? title,
    String? subtitle,
    Color? primaryColor,
    HuxChartSize size = HuxChartSize.medium,
    bool animated = true,
    Duration animationDuration = const Duration(milliseconds: 800),
  }) {
    return HuxChart(
      key: key,
      data: data,
      type: HuxChartType.line,
      xField: xField,
      yField: yField,
      colorField: colorField,
      title: title,
      subtitle: subtitle,
      primaryColor: primaryColor,
      size: size,
      animated: animated,
      animationDuration: animationDuration,
    );
  }

  /// Creates a bar chart
  static HuxChart bar({
    Key? key,
    required List<Map<String, dynamic>> data,
    required String xField,
    required String yField,
    String? colorField,
    String? title,
    String? subtitle,
    Color? primaryColor,
    HuxChartSize size = HuxChartSize.medium,
    bool animated = true,
    Duration animationDuration = const Duration(milliseconds: 800),
  }) {
    return HuxChart(
      key: key,
      data: data,
      type: HuxChartType.bar,
      xField: xField,
      yField: yField,
      colorField: colorField,
      title: title,
      subtitle: subtitle,
      primaryColor: primaryColor,
      size: size,
      animated: animated,
      animationDuration: animationDuration,
    );
  }


} 