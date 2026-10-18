import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rosey/models/NewAppointmentForm.dart';

class AddNewAppointmentScreen extends StatefulWidget {
  const AddNewAppointmentScreen({super.key});

  @override
  State<AddNewAppointmentScreen> createState() =>
      _AddNewAppointmentScreenState();
}

class _AddNewAppointmentScreenState extends State<AddNewAppointmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NewAppointmentForm _newAppointmentForm = NewAppointmentForm();
  final TextEditingController _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  BuildingType? _buildingType;

  static const double paddingValue = 18;

  Widget _timeField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<TimeOfDay> onSelected,
    required FormFieldSetter<String>? onSaved,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.access_time),
      ),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          ),
        );

        if (time != null) {
          setState(() {
            controller.text = 
                '${time.hour.toString().padLeft(2, '0')}:'
                '${time.minute.toString().padLeft(2, '0')}';
            onSelected(time);
          });
        }
      },
      onSaved: onSaved,
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: paddingValue,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        tooltip: 'Voltar',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Text(
                      "Solicitar Agendamento",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: paddingValue,
                      ),
                      child: Text(
                        "Vamos cuidar do seu lar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: paddingValue,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        validator: (String? inValue) {
                          if (inValue == null || inValue.isEmpty) {
                            return "Campo obrigatório";
                          }

                          return null;
                        },
                        onSaved: (String? inValue) {
                          _newAppointmentForm.address = inValue;
                        },
                        decoration: InputDecoration(
                          hintText: "Rua, número e complemento",
                          labelText: "Endereço",
                          suffixIcon: Icon(Icons.add_location),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: paddingValue,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: _dateController,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );

                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                              _dateController.text =
                                  '${date.day.toString().padLeft(2, '0')}/'
                                  '${date.month.toString().padLeft(2, '0')}/'
                                  '${date.year}';
                            });
                          }
                        },
                        onSaved: (_) {
                          _newAppointmentForm.date = _selectedDate;
                        },
                        decoration: InputDecoration(
                          hintText: "dd/mm/aaaa",
                          labelText: "Data",
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: paddingValue,
                      ),
                      child: Text(
                        "Intervalo de horário",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: paddingValue,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _timeField(
                              label: 'Início',
                              controller: _startTimeController,
                              onSelected: (time) => _startTime = time,
                              onSaved: (_) {
                                _newAppointmentForm.start = _startTime;
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _timeField(
                              label: 'Fim',
                              controller: _endTimeController,
                              onSelected: (time) => _endTime = time,
                              onSaved: (_) {
                                _newAppointmentForm.end = _endTime;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: paddingValue,
                      ),
                      child: Text(
                        "Tipo de imóvel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: paddingValue,
                  ),
                  child: FormField<BuildingType>(
                    initialValue: _buildingType,
                    onSaved: (value) {
                      _newAppointmentForm.type = value;
                    },
                    builder: (field) => RadioGroup<BuildingType>(
                      groupValue: field.value,
                      onChanged: field.didChange,
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<BuildingType>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              value: BuildingType.apartment,
                              title: Text(
                                'Apartamento',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<BuildingType>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              value: BuildingType.house,
                              title: Text(
                                'Casa',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: paddingValue,
                      ),
                      child: const Text(
                        "Número de quartos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: paddingValue,
                  ),
                  child: FormField<int>(
                    initialValue: 1,
                    onSaved: (value) {
                      _newAppointmentForm.quantityOfRooms = value;
                    },
                    builder: (field) {
                      final count = field.value ?? 1;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: count > 1
                                ? () => field.didChange(count - 1)
                                : null,
                            icon: Icon(Icons.remove),
                          ),
                          Text('$count'),
                          IconButton(
                            onPressed: () => field.didChange(count + 1),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: paddingValue,
                  ),
                  child: FormField<bool>(
                    initialValue: false,
                    onSaved: (value) {
                      _newAppointmentForm.doTheIroning = value;
                    },
                    builder: (field) => CheckboxListTile(
                      title: const Text("Passar roupa?"),
                      value: field.value ?? false,
                      onChanged: field.didChange,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: paddingValue,
                  ),
                  child: TextFormField(
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      labelText: 'Observações',
                      hintText: 'Adicione detalhes...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    onSaved: (value) {
                      _newAppointmentForm.additionalInfo = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: paddingValue,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                         final form = _formKey.currentState;
                        if (form == null || !form.validate()) return;

                        form.save();

                        print(_newAppointmentForm.address);
                        print(_newAppointmentForm.date);
                        print(_newAppointmentForm.start);
                        print(_newAppointmentForm.end);
                        print(_newAppointmentForm.type);
                        print(_newAppointmentForm.quantityOfRooms);
                        print(_newAppointmentForm.doTheIroning);
                        print(_newAppointmentForm.additionalInfo);
                      },
                      child: Text(
                        "Solicitar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
