import 'custom_calendar.dart';
import 'package:flutter/material.dart';

/// user for DateTime formatting
import 'package:intl/intl.dart';

/// A custom date range picker widget that allows users to select a date range.
/// `const CustomDateRangePicker({
///   Key? key,
///   this.initialStartDate,
///   this.initialEndDate,
///   required this.primaryColor,
///   required this.backgroundColor,
///   required this.onApplyClick,
///   this.barrierDismissible = true,
///   required this.minimumDate,
///   required this.maximumDate,
///   required this.onCancelClick,
/// })`
class CustomDateRangePicker extends StatefulWidget {
  /// The minimum date that can be selected in the calendar.
  final DateTime minimumDate;

  /// The maximum date that can be selected in the calendar.
  final DateTime maximumDate;

  /// Whether the widget can be dismissed by tapping outside of it.
  final bool barrierDismissible;

  /// The initial start date for the date range picker. If not provided, the calendar will default to the minimum date.
  final DateTime? initialStartDate;

  /// The initial end date for the date range picker. If not provided, the calendar will default to the maximum date.
  final DateTime? initialEndDate;

  /// The primary color used for the date range picker.
  final Color primaryColor;

  /// The background color used for the date range picker.
  final Color backgroundColor;

  /// A callback function that is called when the user applies the selected date range.
  final Function(DateTime, DateTime) onApplyClick;

  /// A callback function that is called when the user cancels the selection of the date range.
  final Function() onCancelClick;

  /// Fill color for the Apply button. Falls back to [primaryColor] when null.
  final Color? applyButtonColor;

  /// Fill color for the Cancel button. Falls back to [primaryColor] when null.
  final Color? cancelButtonColor;

  /// Border color for the Apply button. Falls back to [primaryColor] when null.
  final Color? applyBorderColor;

  /// Border color for the Cancel button. Falls back to [primaryColor] when null.
  final Color? cancelBorderColor;

  /// Text color for the Apply button. Falls back to [Colors.white] when null.
  final Color? applyTextColor;

  /// Text color for the Cancel button. Falls back to [Colors.white] when null.
  final Color? cancelTextColor;

  /// Fill color for the selected start/end date. Falls back to [primaryColor].
  final Color? selectedDateColor;

  /// Text color for the selected start/end date. Falls back to [Colors.white].
  final Color? selectedDateTextColor;

  /// Highlight color for dates within the selected range.
  /// Falls back to [primaryColor] with 40% opacity when null.
  final Color? dateRangeColor;

  /// Custom previous-month chevron widget.
  final Widget? leftChevronIcon;

  /// Custom next-month chevron widget.
  final Widget? rightChevronIcon;

  /// Tint for the default chevron icons. Falls back to [Colors.grey].
  final Color? chevronColor;

  /// Font family applied to all text in the picker.
  final String? fontFamily;

  const CustomDateRangePicker({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.primaryColor,
    required this.backgroundColor,
    required this.onApplyClick,
    this.barrierDismissible = true,
    required this.minimumDate,
    required this.maximumDate,
    required this.onCancelClick,
    this.applyButtonColor,
    this.cancelButtonColor,
    this.applyBorderColor,
    this.cancelBorderColor,
    this.applyTextColor,
    this.cancelTextColor,
    this.selectedDateColor,
    this.selectedDateTextColor,
    this.dateRangeColor,
    this.leftChevronIcon,
    this.rightChevronIcon,
    this.chevronColor,
    this.fontFamily,
  });

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  DateTime? startDate;

  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (widget.barrierDismissible) {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      offset: const Offset(4, 4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'From',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    fontFamily: widget.fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  startDate != null
                                      ? DateFormat(
                                          'EEE, dd MMM',
                                        ).format(startDate!)
                                      : '--/-- ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    fontFamily: widget.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 74,
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'To',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    fontFamily: widget.fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  endDate != null
                                      ? DateFormat(
                                          'EEE, dd MMM',
                                        ).format(endDate!)
                                      : '--/-- ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    fontFamily: widget.fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1),
                      CustomCalendar(
                        minimumDate: widget.minimumDate,
                        maximumDate: widget.maximumDate,
                        initialEndDate: widget.initialEndDate,
                        initialStartDate: widget.initialStartDate,
                        primaryColor: widget.primaryColor,
                        selectedDateColor: widget.selectedDateColor,
                        selectedDateTextColor: widget.selectedDateTextColor,
                        dateRangeColor: widget.dateRangeColor,
                        leftChevronIcon: widget.leftChevronIcon,
                        rightChevronIcon: widget.rightChevronIcon,
                        chevronColor: widget.chevronColor,
                        fontFamily: widget.fontFamily,
                        startEndDateChange:
                            (DateTime startDateData, DateTime endDateData) {
                              setState(() {
                                startDate = startDateData;
                                endDate = endDateData;
                              });
                            },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                          top: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      BorderSide(
                                        color:
                                            widget.cancelBorderColor ??
                                            widget.primaryColor,
                                      ),
                                    ),
                                    shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24.0),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                      widget.cancelButtonColor ??
                                          widget.primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    try {
                                      widget.onCancelClick();
                                      Navigator.pop(context);
                                    } catch (_) {}
                                  },
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color:
                                            widget.cancelTextColor ??
                                            Colors.white,
                                        fontFamily: widget.fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(
                                      BorderSide(
                                        color:
                                            widget.applyBorderColor ??
                                            widget.primaryColor,
                                      ),
                                    ),
                                    shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24.0),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                      widget.applyButtonColor ??
                                          widget.primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    try {
                                      widget.onApplyClick(startDate!, endDate!);
                                      Navigator.pop(context);
                                    } catch (_) {}
                                  },
                                  child: Center(
                                    child: Text(
                                      'Apply',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color:
                                            widget.applyTextColor ??
                                            Colors.white,
                                        fontFamily: widget.fontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays a custom date range picker dialog box.
/// `context` The context in which to show the dialog.
/// `dismissible` A boolean value indicating whether the dialog can be dismissed by tapping outside of it.
/// `minimumDate` A DateTime object representing the minimum allowable date that can be selected in the date range picker.
/// `maximumDate` A DateTime object representing the maximum allowable date that can be selected in the date range picker.
/// `startDate` A nullable DateTime object representing the initial start date of the date range selection.
/// `endDate` A nullable DateTime object representing the initial end date of the date range selection.
/// `onApplyClick` A function that takes two DateTime parameters representing the selected start and end dates, respectively, and is called when the user taps the "Apply" button.
/// `onCancelClick` A function that is called when the user taps the "Cancel" button.
/// `backgroundColor` The background color of the dialog.
/// `primaryColor` The primary color of the dialog.
/// `fontFamily` The font family to use for the text in the dialog.

void showCustomDateRangePicker(
  BuildContext context, {
  required bool dismissible,
  required DateTime minimumDate,
  required DateTime maximumDate,
  DateTime? startDate,
  DateTime? endDate,
  required Function(DateTime startDate, DateTime endDate) onApplyClick,
  required Function() onCancelClick,
  required Color backgroundColor,
  required Color primaryColor,
  String? fontFamily,
  Color? applyButtonColor,
  Color? cancelButtonColor,
  Color? applyBorderColor,
  Color? cancelBorderColor,
  Color? applyTextColor,
  Color? cancelTextColor,
  Color? selectedDateColor,
  Color? selectedDateTextColor,
  Color? dateRangeColor,
  Widget? leftChevronIcon,
  Widget? rightChevronIcon,
  Color? chevronColor,
}) {
  /// Request focus to take it away from any input field that might be in focus
  FocusScope.of(context).requestFocus(FocusNode());

  /// Show the CustomDateRangePicker dialog box
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => CustomDateRangePicker(
      barrierDismissible: true,
      backgroundColor: backgroundColor,
      primaryColor: primaryColor,
      minimumDate: minimumDate,
      maximumDate: maximumDate,
      initialStartDate: startDate,
      initialEndDate: endDate,
      onApplyClick: onApplyClick,
      onCancelClick: onCancelClick,
      fontFamily: fontFamily,
      applyButtonColor: applyButtonColor,
      cancelButtonColor: cancelButtonColor,
      applyBorderColor: applyBorderColor,
      cancelBorderColor: cancelBorderColor,
      applyTextColor: applyTextColor,
      cancelTextColor: cancelTextColor,
      selectedDateColor: selectedDateColor,
      selectedDateTextColor: selectedDateTextColor,
      dateRangeColor: dateRangeColor,
      leftChevronIcon: leftChevronIcon,
      rightChevronIcon: rightChevronIcon,
      chevronColor: chevronColor,
    ),
  );
}
