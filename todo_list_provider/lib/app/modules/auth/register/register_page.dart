import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      var success = controller.success;
      var error = controller.error;

      if (success) {
        Navigator.of(context).pop(controller);
      } else if (error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error,
            ),

            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),

          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),

              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),

            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
      
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      
            child: Form(
              key: _formkey,

              child: Column(
                children: [
                  TodoListField(
                    label: 'E-Mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-Mail obrigatório'),
                      Validatorless.email('E-Mail inválido'),
                    ]),
                  ),
      
                  const SizedBox(
                     height: 20,
                  ),
      
                  TodoListField(
                    label: 'Senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve ter pelo menos 6 caracteres'),
                    ]),
                  ),
      
                  const SizedBox(
                     height: 20,
                  ),
      
                  TodoListField(
                    label: 'Confirma Senha',
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.compare(
                        _passwordEC,
                        'Senha diferente de confirmação',
                      ),
                    ]),
                  ),
      
                  const SizedBox(
                     height: 20,
                  ),
      
                  Align(
                    alignment: Alignment.bottomRight,
                    
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formkey.currentState?.validate() ?? false;

                        if (formValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          context.read<RegisterController>().registerUser(
                                email,
                                password,
                              );
                        }
                      },
                  
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                  
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Salvar"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
