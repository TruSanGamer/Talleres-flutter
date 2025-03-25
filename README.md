# 📱 Aplicación Flutter: Navegación y Widgets Interactivos - v1.0

Este proyecto es una muestra personalizada de una aplicación Flutter que implementa navegación entre pantallas, visualización de datos con `GridView`, interacción mediante `Switch`, estructura de pestañas con `TabBar` y paneles informativos usando `ExpansionTile`. Además, incluye seguimiento del ciclo de vida de los widgets para propósitos educativos y de depuración.

## 🚀 Funcionalidades Principales

- **Navegación con paso de datos** usando `Navigator.push()` hacia otras vistas.
- **Visualización de elementos** en forma de cuadrícula mediante `GridView`.
- **Cambio de pestañas** a través de `TabBar` que organiza la interfaz en secciones.
- **Switch interactivo** para activar o desactivar opciones.
- **Paneles informativos** que se expanden con `ExpansionTile`.
- **Registro del ciclo de vida** del widget principal a través de mensajes en consola (`print()`).

## 📌 Detalles de Implementación

1. **Navegación:** La aplicación permite la transición a la pantalla `FormView`, enviando información contextual desde la pantalla principal.
2. **GridView:** Muestra una serie de elementos en un diseño de dos columnas, con navegación al tocarlos.
3. **TabBar:** Organiza la pantalla principal en tres pestañas:  
   - *Lista:* muestra elementos interactivos.  
   - *Opciones:* permite al usuario activar o desactivar una opción mediante un interruptor.  
   - *Info:* ofrece detalles del proyecto mediante paneles desplegables.
4. **Switch:** Cambia dinámicamente el estado de una variable booleana utilizando `setState()`.
5. **ExpansionTile:** Se usa para mostrar secciones informativas que pueden expandirse o contraerse según el interés del usuario.

## 🛠️ Registro del Ciclo de Vida (Salida en consola)

Durante la ejecución se imprime información clave sobre el ciclo de vida de los widgets para fines educativos:

### ▶️ Al iniciar la app:
🟢 initState() de MyHomePage 🔵 didChangeDependencies() de MyHomePage 🟡 build() de MyHomePage

### 🔄 Al navegar a `FormView`:
➡ Navegando a FormView con Elemento X 🟢 initState() de FormView 🔵 didChangeDependencies() de FormView 🟡 build() de FormView

### 🧩 Al interactuar con `TextField` o `Switch`:
⚡ setState() - Cambio detectado 🟡 build() actualizado

### ❌ Al cerrar `FormView`:
🔴 dispose() de FormView

### 🚪 Al cerrar la app:


---

🔹 *Desarrollado con Flutter y Dart - Proyecto versión 1.0*

👨‍💻 Autor: Santiago Trujillo 
📧 Contacto: santiago.trujillo01@uceva.edu.co
📆 Última actualización: Marzo 2025
