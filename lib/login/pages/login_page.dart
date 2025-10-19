import 'package:flutter/material.dart';
import 'package:franq_store/login/controllers/login_page_controller.dart';
import 'package:franq_store/utils/constants.dart';
import 'package:franq_store/widgets/my_text_form_field.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {

  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginPageController());
    return Scaffold(
      body: GetBuilder(
        init: Get.find<LoginPageController>(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(defaultPadding * 2),
            decoration: BoxDecoration(
              color: Colors.white54,
              image: DecorationImage(
                image: NetworkImage('https://franq.com.br/wp-content/uploads/2023/03/cropped-Prancheta-1@3x-2.png'),
                // alignment: AlignmentGeometry.topCenter,
                fit: BoxFit.fill
              ),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                spacing: defaultPadding,
                children: [
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                  MyTextFormField(
                    controller.userController,
                    () => null,
                    'Email',
                    Icons.person,
                  ),
                  MyTextFormField(
                    controller.passwordController,
                    () => null,
                    'Password',
                    Icons.person,
                    obscureText: true,
                  ),
                  InkWell(
                    onTap: () async => await controller.login(),
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding * 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: defaultPadding,
                        children: [
                          Icon(Icons.input_sharp),
                          Text('Login')
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}