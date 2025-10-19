import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Importa o arquivo gerado. Ele contém a função openStore().
import 'objectbox.g.dart'; 

class ObjectBox {
  /// O Store do seu aplicativo.
  late final Store store;

  ObjectBox._create(this.store);

  /// Cria uma instância assíncrona do ObjectBox para uso em todo o aplicativo.
  static Future<ObjectBox> create() async {
    // Para Android, pega o diretório de documentos para armazenar o banco.
    // openStore() é definido em objectbox.g.dart.
    final docsDir = await getApplicationDocumentsDirectory();
    
    // Opcionalmente, você pode especificar um subdiretório:
    final store = await openStore(directory: p.join(docsDir.path, "objectbox"));
    
    return ObjectBox._create(store);
  }

  static Future<void> deleteObjectBoxDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, "objectbox"); // O nome da sua pasta DB

    final directory = Directory(dbPath);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
      log('ObjectBox DB deletado com sucesso em $dbPath');
    }
  }
}