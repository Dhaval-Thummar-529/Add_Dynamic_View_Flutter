import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                for (int i = 0; i < controller.selectedValues.length; i++)
                  dropDownCard(i),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        var selectedValue = "Status";
                        controller.selectedValues.add(selectedValue);
                      },
                      child: Text("Add DropDown"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        controller.onSavedPressed();
                        controller.selectedValues.clear();
                        controller.selectedValues
                            .add(controller.selectedValue.value);
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
                controller.savedList.isEmpty
                    ? const Text("No Data Available!")
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          itemCount: controller.savedList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(child: Text(controller.savedList[index]));
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              DropdownButton(
                isDense: true,
                iconEnabledColor: Colors.blue,
                value: controller.selectedValues[index].toString(),
                items: controller.dropdownItems,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  controller.selectedValues[index] = (value!);
                },
                isExpanded: false,
                borderRadius: BorderRadius.circular(8.0),
                //Todo: Add decoration to this element
              ),
              IconButton(
                onPressed: () {
                  controller.selectedValues.removeAt(index);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomeController extends GetxController {
  var selectedValue = "Status".obs;

  var selectedValues = <String>[].obs;

  List<String> statusList = ["Status", "Todo", "active"];

  var savedList = <String>[].obs;

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
    selectedValues.add(selectedValue.value);
    super.onInit();
  }

  onSavedPressed() {
    savedList.addAll(selectedValues.value);
  }
}
