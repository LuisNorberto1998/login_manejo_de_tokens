import 'dart:io';

import 'package:formvalidation/src/providers/productos_providers.dart';
import 'package:rxdart/rxdart.dart';

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosBloc {
  //Streamcontroller
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  //Referencia para realizar la petición a cada proceso
  final _productoProvider = new ProductosProvider();

  //Escuchar streams
  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  //Implementar metodos para cargar, agregar, etc, productos
  void cargarProductos() async {
    final productos = await _productoProvider.cargarProductos();
    _productosController.sink.add(productos);
  }

  //Agregar producto
  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productoProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  //Subir foto
  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productoProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  //Editar el producto
  void editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productoProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  //Borrar producto
  void borrarProducto(String id) async {
    await _productoProvider.borrarProducto(id);
  }

  dispose() {
    _cargandoController.close();
    _productosController.close();
  }
}
