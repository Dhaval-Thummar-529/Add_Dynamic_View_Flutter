import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dynamic Change'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({super.key, required this.title});

  final MyHomeController controller = Get.put(MyHomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DataView(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller.changeNextView(
                          controller.dataModel.length - 1,
                          DataModel(
                              name: controller.nameSelected.value,
                              age: controller.ageSelected.value));
                    },
                    child: const Text("Change Next View"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller
                          .changeToPrevious(controller.dataModel.length - 1);
                    },
                    child: const Text("Change Previous View"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataView extends StatelessWidget {
  DataView({super.key});

  final controller = Get.find<MyHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                DropdownButton(
                  isDense: true,
                  iconEnabledColor: Colors.blue,
                  value: controller.nameSelected.value,
                  items: controller.dropdownItems,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (value) {
                    controller.nameSelected.value = (value!);
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8.0),
                  //Todo: Add decoration to this element
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  isDense: true,
                  iconEnabledColor: Colors.blue,
                  value: controller.ageSelected.value,
                  items: controller.dropdownItems,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (value) {
                    controller.ageSelected.value = (value!);
                  },
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8.0),
                  //Todo: Add decoration to this element
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomeController extends GetxController {
  var selectedValue = "Status".obs;

  // var selectedValues = <String>[].obs;

  var nameSelected = "".obs;
  var ageSelected = "".obs;

  List<String> statusList = ["Status", "Todo", "Active"];

  var savedList = <String>[].obs;

  List<DataModel> dataModel = <DataModel>[].obs;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: statusList[0], child: const Text("Status")),
      DropdownMenuItem(value: statusList[1], child: const Text("Todo")),
      DropdownMenuItem(value: statusList[2], child: const Text("Active")),
    ];
    return menuItems;
  }

  @override
  void onInit() {
    dataModel.add(DataModel());
    nameSelected(selectedValue.value);
    ageSelected(selectedValue.value);
    for (int i = 0; i < dataModel.length; i++) {
      print(
          "Init ::: Name: ${dataModel[i].name} :::: Age: ${dataModel[i].age}");
    }
    // selectedValues.add(selectedValue.value);
    super.onInit();
  }

  changeNextView(index, DataModel dm) {
    nameSelected(selectedValue.value);
    ageSelected(selectedValue.value);
    dataModel[index].name = dm.name;
    dataModel[index].age = dm.age;
    for (int i = 0; i < dataModel.length; i++) {
      print(
          "Added $i ::: Name: ${dataModel[i].name} :::: Age: ${dataModel[i].age}");
    }
    dataModel.add(DataModel());
  }

  changeToPrevious(index) {
    dataModel.removeAt(index);
    update();
    if (index == 0) {
      dataModel.add(DataModel());
      nameSelected(selectedValue.value);
      ageSelected(selectedValue.value);
    } else {
      nameSelected(dataModel[index - 1].name);
      ageSelected(dataModel[index - 1].age);
    }
    for (int i = 0; i < dataModel.length; i++) {
      print(
          "removed $i ::: Name: ${dataModel[i].name} :::: Age: ${dataModel[i].age}");
    }
  }

  onSavedPressed() {}
}

class DataModel {
  String? name;
  String? age;

  DataModel({this.name, this.age});
}
