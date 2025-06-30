import 'package:flutter/material.dart';
import 'package:hux/hux.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hux UI Demo',
      theme: HuxTheme.lightTheme,
      darkTheme: HuxTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoading = false;

  // Theme state
  String _selectedTheme = 'white';
  Color get _currentPrimaryColor => HuxColors.getPresetColor(_selectedTheme);

  // Button size state
  HuxButtonSize _selectedButtonSize = HuxButtonSize.medium;

  // Global keys for each section
  final _buttonsKey = GlobalKey();
  final _textFieldsKey = GlobalKey();
  final _cardsKey = GlobalKey();
  final _chartsKey = GlobalKey();
  final _loadingKey = GlobalKey();
  final _contextMenuKey = GlobalKey();

  // Navigation items
  late final List<NavigationItem> _navigationItems;

  @override
  void initState() {
    super.initState();
    _navigationItems = [
      NavigationItem(
        title: 'Buttons',
        icon: Icons.smart_button,
        key: _buttonsKey,
      ),
      NavigationItem(
        title: 'Text Fields',
        icon: Icons.text_fields,
        key: _textFieldsKey,
      ),
      NavigationItem(
        title: 'Cards',
        icon: Icons.credit_card,
        key: _cardsKey,
      ),
      NavigationItem(
        title: 'Charts',
        icon: Icons.analytics,
        key: _chartsKey,
      ),
      NavigationItem(
        title: 'Context Menu',
        icon: Icons.menu,
        key: _contextMenuKey,
      ),
      NavigationItem(
        title: 'Loading',
        icon: Icons.refresh,
        key: _loadingKey,
      ),
    ];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });

    if (_isLoading) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Navigation Sidebar
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? HuxColors.black90
                  : HuxColors.white,
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? HuxColors.white20
                      : HuxColors.black20,
                ),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? HuxColors.white20
                            : HuxColors.black20,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hux UI',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? HuxColors.white
                                      : HuxColors.black,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Component Library',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? HuxColors.white60
                                  : HuxColors.black60,
                            ),
                      ),
                    ],
                  ),
                ),

                // Theme Selector
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? HuxColors.white20
                            : HuxColors.black20,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Button Theme',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? HuxColors.white80
                                      : HuxColors.black80,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? HuxColors.black70
                              : HuxColors.white5,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? HuxColors.white20
                                    : HuxColors.black20,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTheme,
                            isExpanded: true,
                            dropdownColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? HuxColors.black80
                                    : HuxColors.white,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? HuxColors.white80
                                      : HuxColors.black80,
                                ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? HuxColors.white60
                                  : HuxColors.black60,
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedTheme = newValue;
                                });
                              }
                            },
                            items: HuxColors.availablePresetColors
                                .map<DropdownMenuItem<String>>(
                                    (String colorName) {
                              final color = HuxColors.getPresetColor(colorName);
                              return DropdownMenuItem<String>(
                                value: colorName,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? HuxColors.white30
                                              : HuxColors.black30,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      colorName[0].toUpperCase() +
                                          colorName.substring(1),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? HuxColors.white80
                                                    : HuxColors.black80,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: _navigationItems.length,
                    itemBuilder: (context, index) {
                      final item = _navigationItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _scrollToSection(item.key),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item.icon,
                                    size: 20,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? HuxColors.white70
                                        : HuxColors.black70,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? HuxColors.white70
                                              : HuxColors.black70,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: HuxLoadingOverlay(
              isLoading: _isLoading,
              message: 'Processing...',
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(64),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Buttons Section
                      Container(
                        key: _buttonsKey,
                        child: HuxCard(
                          title: 'Buttons',
                          subtitle: 'Different button variants and sizes',
                          child: Column(
                            children: [
                              const SizedBox(height: 16),

                              // Size Selector Tabs
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? HuxColors.black70
                                      : HuxColors.white5,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? HuxColors.white20
                                        : HuxColors.black20,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildSizeTab(
                                          'Small', HuxButtonSize.small),
                                    ),
                                    Expanded(
                                      child: _buildSizeTab(
                                          'Medium', HuxButtonSize.medium),
                                    ),
                                    Expanded(
                                      child: _buildSizeTab(
                                          'Large', HuxButtonSize.large),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Button Variants - Fixed Height Container
                              SizedBox(
                                height:
                                    48, // Fixed height to prevent layout shifts
                                child: Center(
                                  child: Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      HuxButton(
                                        onPressed: () =>
                                            _showSnackBar('Primary pressed'),
                                        primaryColor: _currentPrimaryColor,
                                        size: _selectedButtonSize,
                                        child: const Text('Primary'),
                                      ),
                                      HuxButton(
                                        onPressed: () =>
                                            _showSnackBar('Secondary pressed'),
                                        variant: HuxButtonVariant.secondary,
                                        size: _selectedButtonSize,
                                        child: const Text('Secondary'),
                                      ),
                                      HuxButton(
                                        onPressed: () =>
                                            _showSnackBar('Outline pressed'),
                                        variant: HuxButtonVariant.outline,
                                        size: _selectedButtonSize,
                                        child: const Text('Outline'),
                                      ),
                                      HuxButton(
                                        onPressed: () =>
                                            _showSnackBar('Ghost pressed'),
                                        variant: HuxButtonVariant.ghost,
                                        size: _selectedButtonSize,
                                        child: const Text('Ghost'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 16),

                              // With Icon Example - Fixed Height Container
                              SizedBox(
                                height:
                                    48, // Fixed height to prevent layout shifts
                                child: Center(
                                  child: HuxButton(
                                    onPressed: _toggleLoading,
                                    primaryColor: _currentPrimaryColor,
                                    size: _selectedButtonSize,
                                    icon: FeatherIcons.upload,
                                    child: const Text('With Icon'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Text Fields Section
                      Container(
                        key: _textFieldsKey,
                        child: HuxCard(
                          title: 'Text Fields',
                          subtitle: 'Input components with validation',
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              HuxTextField(
                                controller: _emailController,
                                label: 'Email',
                                hint: 'Enter your email address',
                                prefixIcon: const Icon(FeatherIcons.mail),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              HuxTextField(
                                controller: _passwordController,
                                label: 'Password',
                                hint: 'Enter your password',
                                prefixIcon: const Icon(FeatherIcons.lock),
                                suffixIcon: const Icon(FeatherIcons.eye),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              const Row(
                                children: [
                                  Expanded(
                                    child: HuxTextField(
                                      label: 'Small',
                                      size: HuxTextFieldSize.small,
                                      hint: 'Small text field',
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: HuxTextField(
                                      label: 'Large',
                                      size: HuxTextFieldSize.large,
                                      hint: 'Large text field',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Cards Section
                      Container(
                        key: _cardsKey,
                        child: const HuxCard(
                          title: 'Cards',
                          subtitle:
                              'Container components for content organization',
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: HuxCard(
                                      title: 'Simple Card',
                                      child: Text(
                                          'This is a simple card with just a title and content.'),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: HuxCard(
                                      title: 'Card with Subtitle',
                                      subtitle:
                                          'This card has both title and subtitle',
                                      child: Text(
                                          'Cards can have optional subtitles for additional context.'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Charts Section
                      Container(
                        key: _chartsKey,
                        child: HuxCard(
                          title: 'Charts',
                          subtitle: 'Data visualization with cristalyse',
                          child: Column(
                            children: [
                              const SizedBox(height: 16),

                              // Sample chart data
                              Row(
                                children: [
                                  Expanded(
                                    child: HuxChart(
                                      data: _getSampleLineData(),
                                      type: HuxChartType.line,
                                      xField: 'day',
                                      yField: 'calories',
                                      title: 'Daily Calories',
                                      subtitle: 'Calorie tracking over time',
                                      size: HuxChartSize.small,
                                      primaryColor: _currentPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: HuxChart(
                                      data: _getSampleBarData(),
                                      type: HuxChartType.bar,
                                      xField: 'product',
                                      yField: 'revenue',
                                      title: 'Product Revenue',
                                      subtitle: 'Revenue by product',
                                      size: HuxChartSize.small,
                                      primaryColor: _currentPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Context Menu Section
                      Container(
                        key: _contextMenuKey,
                        child: HuxCard(
                          title: 'Context Menu',
                          subtitle: 'Right-click interactive context menus',
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Right-click on any of the items below to see the context menu:',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? HuxColors.white70
                                      : HuxColors.black70,
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              // Context Menu Examples
                              Row(
                                children: [
                                  Expanded(
                                    child: HuxContextMenu(
                                      menuItems: [
                                        HuxContextMenuItem(
                                          text: 'Copy',
                                          icon: FeatherIcons.copy,
                                          onTap: () => _showSnackBar('Copy action triggered'),
                                        ),
                                        HuxContextMenuItem(
                                          text: 'Paste',
                                          icon: FeatherIcons.clipboard,
                                          onTap: () => _showSnackBar('Paste action triggered'),
                                          isDisabled: true,
                                        ),
                                        const HuxContextMenuDivider(),
                                        HuxContextMenuItem(
                                          text: 'Share',
                                          icon: FeatherIcons.share2,
                                          onTap: () => _showSnackBar('Share action triggered'),
                                        ),
                                      ],
                                      child: HuxCard(
                                        title: 'Document',
                                        subtitle: 'Right-click for options',
                                        child: Container(
                                          height: 60,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            FeatherIcons.fileText,
                                            size: 32,
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? HuxColors.white50
                                                : HuxColors.black50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: HuxContextMenu(
                                      menuItems: [
                                        HuxContextMenuItem(
                                          text: 'Edit',
                                          icon: FeatherIcons.edit2,
                                          onTap: () => _showSnackBar('Edit action triggered'),
                                        ),
                                        HuxContextMenuItem(
                                          text: 'Duplicate',
                                          icon: FeatherIcons.copy,
                                          onTap: () => _showSnackBar('Duplicate action triggered'),
                                        ),
                                        const HuxContextMenuDivider(),
                                        HuxContextMenuItem(
                                          text: 'Delete',
                                          icon: FeatherIcons.trash2,
                                          onTap: () => _showSnackBar('Delete action triggered'),
                                          isDestructive: true,
                                        ),
                                      ],
                                      child: HuxCard(
                                        title: 'Project',
                                        subtitle: 'Right-click for actions',
                                        child: Container(
                                          height: 60,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            FeatherIcons.folder,
                                            size: 32,
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? HuxColors.white50
                                                : HuxColors.black50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Button with Context Menu
                              HuxContextMenu(
                                menuItems: [
                                  HuxContextMenuItem(
                                    text: 'Save',
                                    icon: FeatherIcons.save,
                                    onTap: () => _showSnackBar('Save action triggered'),
                                  ),
                                  HuxContextMenuItem(
                                    text: 'Export',
                                    icon: FeatherIcons.download,
                                    onTap: () => _showSnackBar('Export action triggered'),
                                  ),
                                  const HuxContextMenuDivider(),
                                  HuxContextMenuItem(
                                    text: 'Reset',
                                    icon: FeatherIcons.refreshCw,
                                    onTap: () => _showSnackBar('Reset action triggered'),
                                    isDestructive: true,
                                  ),
                                ],
                                child: HuxButton(
                                  onPressed: () => _showSnackBar('Button clicked normally'),
                                  primaryColor: _currentPrimaryColor,
                                  icon: FeatherIcons.settings,
                                  child: const Text('Right-click for More Options'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Loading Section
                      Container(
                        key: _loadingKey,
                        child: HuxCard(
                          title: 'Loading Indicators',
                          subtitle: 'Different loading states and sizes',
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      HuxLoading(size: HuxLoadingSize.small),
                                      SizedBox(height: 8),
                                      Text('Small'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      HuxLoading(size: HuxLoadingSize.medium),
                                      SizedBox(height: 8),
                                      Text('Medium'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      HuxLoading(size: HuxLoadingSize.large),
                                      SizedBox(height: 8),
                                      Text('Large'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      HuxLoading(
                                          size: HuxLoadingSize.extraLarge),
                                      SizedBox(height: 8),
                                      Text('XL'),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              HuxButton(
                                onPressed: _toggleLoading,
                                variant: HuxButtonVariant.outline,
                                child: Text(_isLoading
                                    ? 'Stop Loading'
                                    : 'Show Loading Overlay'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sample data generators for charts
  List<Map<String, dynamic>> _getSampleLineData() {
    return [
      {'day': 1, 'calories': 520, 'type': 'Daily Goal'},
      {'day': 2, 'calories': 480, 'type': 'Daily Goal'},
      {'day': 3, 'calories': 440, 'type': 'Daily Goal'},
      {'day': 4, 'calories': 580, 'type': 'Daily Goal'},
      {'day': 5, 'calories': 520, 'type': 'Daily Goal'},
      {'day': 6, 'calories': 610, 'type': 'Daily Goal'},
      {'day': 7, 'calories': 490, 'type': 'Daily Goal'},
      {'day': 8, 'calories': 550, 'type': 'Daily Goal'},
      {'day': 9, 'calories': 580, 'type': 'Daily Goal'},
      {'day': 10, 'calories': 470, 'type': 'Daily Goal'},
      {'day': 11, 'calories': 620, 'type': 'Daily Goal'},
      {'day': 12, 'calories': 540, 'type': 'Daily Goal'},
      {'day': 13, 'calories': 510, 'type': 'Daily Goal'},
      {'day': 14, 'calories': 590, 'type': 'Daily Goal'},
    ];
  }

  List<Map<String, dynamic>> _getSampleBarData() {
    return [
      {'product': 'Mobile', 'revenue': 450},
      {'product': 'Tablet', 'revenue': 320},
      {'product': 'Laptop', 'revenue': 580},
      {'product': 'Desktop', 'revenue': 290},
      {'product': 'Watch', 'revenue': 180},
    ];
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildSizeTab(String label, HuxButtonSize size) {
    final isSelected = _selectedButtonSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedButtonSize = size;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (Theme.of(context).brightness == Brightness.dark
                  ? HuxColors.white20
                  : HuxColors.black10)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? HuxColors.white
                          : HuxColors.black)
                      : (Theme.of(context).brightness == Brightness.dark
                          ? HuxColors.white60
                          : HuxColors.black60),
                ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final IconData icon;
  final GlobalKey key;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.key,
  });
}
