import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';

class ExtraActivitiesSection extends StatefulWidget {
  final List<Employment> employment;
  const ExtraActivitiesSection({super.key, required this.employment});

  @override
  ExtraActivitiesSectionState createState() => ExtraActivitiesSectionState();
}

class ExtraActivitiesSectionState extends State<ExtraActivitiesSection> {
  final blankEmployment = Employment(title: '', company: '', startdate: DateTime.now(), empid: 0, enddate: DateTime.now());
  Map employmentMap = {};
  bool editing = false;

  @override
  void initState() {
    print(widget.employment.length);
    for (var element in widget.employment) {
      display(element);
     }
    super.initState();
  }

  void display(Employment info) {
    TextEditingController titleC = TextEditingController();
    TextEditingController companyC = TextEditingController();
    TextEditingController dateC = TextEditingController();

    titleC.text = info.title;
    companyC.text = info.company;
    dateC.text = dateTimeToString(info.startdate, info.enddate);

    employmentMap[info.empid] = {
      'empid': info.empid,
      'title': titleC,
      'company': companyC,
      'date': dateC,
    };
    employmentMap[info.empid]['widget'] = (
      Column(
        children: [
          const SizedBox(height: 4,),
          EmploymentField(
            titleC: employmentMap[info.empid]['title'],
            companyC: employmentMap[info.empid]['company'],
            dateC: employmentMap[info.empid]['date'],
            ),
          const SizedBox(height: 4,),
        ],
      )
    );
  }

  void add() {
    UserApi.addEmployment(employment: blankEmployment).then((value) {
      Employment newEmployment = getCorrect(value!)!;
      print(newEmployment.empid);
      display(newEmployment);
      setState(() {});
    });
  }

  void remove(int objectId) async {
    Employment? oldEmployment = getEmployment(objectId);
    if(oldEmployment == null) {
      return;
    }
    UserApi.RemoveEmployment(employment: oldEmployment);
    employmentMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    // employmentMap.forEach((key, value) {
    // Employment? updatedEmployment = getEmployment(key);
    //   if(updatedEmployment != null) {
    //     UserApi.UpdateEmployment(employment: updatedEmployment);
    //   }
    // });
  }

  Employment? getEmployment(int objectId) {
    if(employmentMap.containsKey(objectId) == false) {
      return null;
    }
    DateTimeRange dateTimeRange = stringToDateTimeRange(employmentMap[objectId]['date'].text);

    Employment newEmployment = Employment(
      title: employmentMap[objectId]['title'].text,
      company: employmentMap[objectId]['company'].text,
      empid: employmentMap[objectId]['empid'],
      startdate: dateTimeRange.start,
      enddate: dateTimeRange.end,
    );
    return newEmployment;
  }

  Employment? getCorrect(List<Employment> list) {
    for(var i = 0; i <= list.length-1; i++) {
      if(employmentMap.containsKey(list[i].empid) == false) {
        return list[i];
      }
    }
    return null;
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    if (employmentMap.isEmpty) {
      linkWidgets.add(
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sports_tennis ,color: Colors.grey,size: 100,),
              SizedBox(height: 20),
              Text(
                "No Extra curricular...", 
                style: TextStyle(
                  color: Colors.grey
                )
              )
            ],
          ),
        )
      );
    }
    employmentMap.forEach((key, value) {
      linkWidgets.add(employmentMap[key]['widget']);
      if(editing == true) {
        linkWidgets.add(
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              
              onPressed: (){
                remove(key);
                if(employmentMap.isEmpty == true) {
                  editing = false;
                }
              }, 
              icon: const Icon(Icons.delete)),
          ),
        );
        linkWidgets.add(const SizedBox(height: 4,),);
      }
    });
    return linkWidgets;
  }

  edit() {
    if(employmentMap.isEmpty == true) {
      return;
    }
    setState(() {
      editing = !editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        children: [
          SectionHeadingBar(
            actions: [
              IconButton(
                color: const Color(0xFF333C64),
                onPressed: () {
                if(editing == false) {
                  add();
                }
              }, icon: const Icon(Icons.add)),
              IconButton(
                color: const Color(0xFF333C64),
                onPressed: () {
                  edit();
              }, icon: const Icon(Icons.edit)),
            ],
            children: [
              SectionHeading(text: "EXTRA CURRICULAR",),
            ],
          ),
          const SizedBox(height: 16,),
          ...populate(),
        ]
      )
    );
  }
}

class EmploymentField extends StatefulWidget {
  final TextEditingController titleC;
  final TextEditingController companyC;
  final TextEditingController dateC;
  const EmploymentField({super.key, required this.titleC, required this.companyC, required this.dateC});

  @override
  EmploymentFieldState createState() => EmploymentFieldState();
}

class EmploymentFieldState extends State<EmploymentField> {
  TextEditingController displayDateC = TextEditingController();
  @override
void initState() {
  displayDateC.text = displayDateTimeRange(stringToDateTimeRange(widget.dateC.text));
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
          maxLength: 50,
          controller: widget.companyC,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            counterText: "",
            hintText: "Organisation",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: TextFormField(
          maxLength: 50,
          controller: widget.titleC,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            counterText: "",
            hintText: "Activity",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                datePicker(context).then((value) {
                  if(value != null) {
                    widget.dateC.text = dateTimeToString(value.start, value.end);
                    displayDateC.text = displayDateTimeRange(value);
                  }
                });
              });
            },
            child: TextFormField(
              enabled: false,
              controller: displayDateC,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "Date",
                border: OutlineInputBorder(),
                ),
              ),
          ),
        ),
      ],
    );
  }
}

String dateTimeToString(DateTime start, DateTime end) {
  return "$start/$end";
}

DateTimeRange stringToDateTimeRange(String text) {
  List<String> dates = text.split('/');
  return DateTimeRange(start: DateTime.parse(dates[0]), end: DateTime.parse(dates[1]));
}

String displayDateTimeRange(DateTimeRange dateTimeRange) {
  return "${dateTimeRange.start.year} - ${dateTimeRange.end.year}";
}

Future<DateTimeRange?> datePicker(BuildContext context) async {
  return showDateRangePicker(
      context: context, 
      firstDate: DateTime.now().subtract(const Duration(days:365*100)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
}

