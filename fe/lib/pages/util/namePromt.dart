import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NamePrompt extends StatefulWidget {
  NamePrompt({super.key});

  String? name;
  @override
  State<StatefulWidget> createState() => NamePromtState();

}

class NamePromtState extends State<NamePrompt> {
  final _formKey = GlobalKey<FormState>(); 
  TextEditingController nameController = TextEditingController();
  save() {
    if(_formKey.currentState!.validate() == false) {
      return;
    }
    widget.name = nameController.text;
    Navigator.pop(context);
  }
  cancel() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    
    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.grey.shade300
          ),
          color: Colors.grey.shade100
        ),
        width: 20*w,
        height: 180,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Scaffold(
            body: SizedBox(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 80,
                        width: 15*w,
                        child: TextFormField(
                          maxLength: 50,
                          key: const Key('filename'),
                          controller: nameController,
                          decoration: const InputDecoration(
                            counterText: "",
                            labelText: 'File Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomizableButton(
                            text: 'Save', 
                            width: 7*w, 
                            height: 28, 
                            onTap: () {
                              save();
                            }, 
                            fontSize: w*0.8
                          ),
                          SizedBox(width: w*3,),
                          CustomizableButton(
                            text: 'Cancel', 
                            width: 7*w, 
                            height: 28, 
                            onTap: () {
                              cancel();
                            }, 
                            fontSize: w*0.8
                          )
                        ],
                      )
                    ],
                  ),
                )
              )
            )
          )
        )
      )
    );
  }

}