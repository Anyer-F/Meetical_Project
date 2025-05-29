/*import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // lo añadiremos pronto

class RecordatorioCitasPage extends StatefulWidget {
  @override
  _RecordatorioCitasPageState createState() => _RecordatorioCitasPageState();
}

class _RecordatorioCitasPageState extends State<RecordatorioCitasPage> {
  // Estado:
  String _filtroPaciente = '';
  String _pacienteSeleccionado;
  int _vistaIndex = 0; // 0: Mes, 1: Semana, 2: Día
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  TimeOfDay _horaDesde;
  TimeOfDay _horaHasta;
  TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recordatorio de Citas')),
      body: _buildBody(context),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchField(),
          SizedBox(height: 12),
          _buildPacienteSeleccionado(),
          SizedBox(height: 16),
          _buildSegmentControl(),
          SizedBox(height: 16),
          _buildCalendar(),
          SizedBox(height: 16),
          _buildTimePickers(context),
          SizedBox(height: 16),
          _buildDescriptionField(),
          SizedBox(height: 24),
          _buildReadyButton(),
        ],
      ),
    );
  }

  // 2. Campo de búsqueda de paciente
  Widget _buildSearchField() {
    return TextField(
      onChanged: (v) => setState(() => _filtroPaciente = v),
      decoration: InputDecoration(
        hintText: 'Buscar Paciente',
        filled: true,
        fillColor: Colors.grey.shade200,
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 3. Chip o contenedor que muestra el paciente seleccionado
  Widget _buildPacienteSeleccionado() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        _pacienteSeleccionado ?? 'Paciente Seleccionado',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // 4. Segment control: Mes | Semana | Día
  Widget _buildSegmentControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final labels = ['Mes', 'Semana', 'Día'];
        final selected = _vistaIndex == i;
        return GestureDetector(
          onTap: () => setState(() => _vistaIndex = i),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: selected ? Theme.of(context).primaryColor : Colors.black87,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                color: Colors.white,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }

  // 5. Calendario con table_calendar
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2000),
      lastDay: DateTime.utc(2100),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      onDaySelected: (sel, focus) {
        setState(() {
          _selectedDay = sel;
          _focusedDay = focus;
        });
      },
      calendarStyle: CalendarStyle(
        // personaliza colores si quieres
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false, // quitamos botones extras
        titleCentered: true,
      ),
      calendarFormat:
          _vistaIndex == 0
              ? CalendarFormat.month
              : _vistaIndex == 1
              ? CalendarFormat.week
              : CalendarFormat.twoWeeks, // o .day, según el paquete permita
    );
  }

  // 6. Selectores de hora “De” y “Hasta”
  Widget _buildTimePickers(BuildContext ctx) {
    return Column(
      children: [
        _buildTimePickerRow(
          ctx,
          'De:',
          _horaDesde,
          (t) => setState(() => _horaDesde = t),
        ),
        SizedBox(height: 8),
        _buildTimePickerRow(
          ctx,
          'Hasta:',
          _horaHasta,
          (t) => setState(() => _horaHasta = t),
        ),
      ],
    );
  }

  Widget _buildTimePickerRow(
    BuildContext ctx,
    String label,
    TimeOfDay time,
    ValueChanged<TimeOfDay> onPick,
  ) {
    final text = time == null ? 'Seleccionar hora' : time.format(ctx);
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: ctx,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) onPick(picked);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$label $text',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (time != null)
              GestureDetector(
                onTap: () => onPick(null),
                child: Icon(Icons.close, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }

  // 7. Campo de descripción
  Widget _buildDescriptionField() {
    return TextField(
      controller: _descController,
      decoration: InputDecoration(
        labelText: 'Descripción',
        border: OutlineInputBorder(),
      ),
      maxLines: 2,
    );
  }

  // 8. Botón “Listo”
  Widget _buildReadyButton() {
    return ElevatedButton(
      onPressed: _onSubmit,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text('Listo', style: TextStyle(fontSize: 16)),
      ),
      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
    );
  }

  void _onSubmit() {
    // Aquí envías tu recordatorio: paciente, fecha (_selectedDay),
    // hora desde/hasta, descripción...
    // Llama al caso de uso o muestra un SnackBar de confirmación.
  }
}*/
