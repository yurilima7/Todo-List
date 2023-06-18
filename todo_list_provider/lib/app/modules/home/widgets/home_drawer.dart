import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVM = ValueNotifier<String>('');

  HomeDrawer({ super.key });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70)
            ),

            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  builder: (_, value, __) => CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  ),
                  
                  selector: (context, authProvider) =>
                      authProvider.user?.photoURL ??
                      'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE60QogebgAWTalE1myseY1Hbb5qPM.jpg',
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                      builder: (_, value, __) => Text(
                        value,
                        style: context.textTheme.titleSmall,
                      ),
                      
                      selector: (context, authProvider) =>
                          authProvider.user?.displayName ?? 'Não informado',
                    ),
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: const Text('Alterar Nome'),
            onTap: () => showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Alterar nome'),

                  content: TextField(
                    onChanged: (value) => nameVM.value = value,
                  ),

                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    TextButton(
                      onPressed: () async {
                        final nameValue = nameVM.value;
                        final navigator = Navigator.of(context);

                        if (nameValue.isEmpty) {
                          Messages.of(context).showError('Nome obrigatório');
                        } else {
                          Loader.show(context);

                          await context
                              .read<UserService>()
                              .updateDisplayName(nameValue);
                              
                          Loader.hide();

                          navigator.pop();
                        }
                      },
                      child: const Text('Alterar'),
                    ),
                  ],
                );
              },
            ),
  
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}