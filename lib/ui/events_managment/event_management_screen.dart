import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:evently_c16_sun/data/firebase/events_data_base.dart';
import 'package:evently_c16_sun/data/models/category.dart';
import 'package:evently_c16_sun/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventManagementScreen extends StatefulWidget {
  static const String routeName = "/event-management";

  const EventManagementScreen({super.key});

  @override
  State<EventManagementScreen> createState() => _EventManagementScreenState();
}

class _EventManagementScreenState extends State<EventManagementScreen> {
  Category selectedCategory = Category.categories[0];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  late AppConfigProvider appConfigProvider;

  DateTime? selectedDate;
  TimeOfDay? currentTime;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(selectedCategory.imagePath),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            DefaultTabController(
              length: Category.categories.length,
              child: TabBar(
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(),
                labelPadding: EdgeInsets.symmetric(horizontal: 8),

                isScrollable: true,
                onTap: (index) {
                  selectedCategory = Category.categories[index];
                  setState(() {});
                },
                tabs:
                    Category.categories
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  selectedCategory.id == e.id
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  e.iconData,
                                  color:
                                      selectedCategory.id == e.id
                                          ? AppColors.offWhite
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  appConfigProvider.isEn()
                                      ? e.nameEn
                                      : e.nameAr,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium!.copyWith(
                                    color:
                                        selectedCategory.id == e.id
                                            ? AppColors.offWhite
                                            : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 16),
            Text("Title"),
            SizedBox(height: 8),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Event Title",
                prefixIcon: Icon(Icons.create),
              ),
            ),
            SizedBox(height: 16),
            Text("Description"),
            SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              maxLines: 6,
              decoration: InputDecoration(hintText: "Event Description"),
            ),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 8),
                Text("Event Date"),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    DateTime? newSelectedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (newSelectedDate != null) {
                      selectedDate = newSelectedDate;
                      setState(() {});
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? "Choose Date"
                        : DateFormat("dd/MM/yyyy").format(selectedDate!),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 8),
                Text("Event Time"),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    TimeOfDay? newSelectedTime = await showTimePicker(
                      context: context,
                      initialTime: currentTime ?? TimeOfDay.now(),
                    );
                    if (newSelectedTime != null) {
                      currentTime = newSelectedTime;
                      setState(() {});
                    }
                  },
                  child: Text(
                    currentTime == null
                        ? "Choose Date"
                        : currentTime!.format(context),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedDate != null &&
                    currentTime != null) {
                  try {
                    EventsDataBase.createEvent(
                      Event(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate?.millisecondsSinceEpoch,
                        time:
                            DateTime(
                              00,
                              00,
                              00,
                              currentTime!.hour,
                              currentTime!.minute,
                              00,
                            ).millisecondsSinceEpoch,
                        categoryId: selectedCategory.id,
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text("Create Event"),
            ),
          ],
        ),
      ),
    );
  }
}
