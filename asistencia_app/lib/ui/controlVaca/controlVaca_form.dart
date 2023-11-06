import 'package:asistencia_app/apis/controlVaca_api.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/modelo/ControlVacaModelo.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlVacaForm extends StatefulWidget {
  @override
  _ControlVacaFormState createState() => _ControlVacaFormState();
}

class _ControlVacaFormState extends State<ControlVacaForm> {

  late String _etapaDetalle="";
  late String _fechaProg="";

  TextEditingController _fechaReal = new TextEditingController();
  DateTime? selectedDate;
  late String _pesoVivo="";
  late String _preno="";
  late String _condicionCorporal="";
  late String _tieneMastitis="";
  late String _tratamiento="";



  Position? currentPosition;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;



  @override


  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );



  void capturaEtapaDetalle(valor){ this._etapaDetalle=valor;}

  void capturaFechaProg(valor){ this._fechaProg=valor;}
  void capturaFechaReal(valor){ this._fechaReal.text=valor;}
  void capturaPesoVivo(valor){ this._pesoVivo=valor;}
  void capturaPreno(valor){ this._preno=valor;}
  void capturaCondicionCorporal(valor){ this._condicionCorporal=valor;}
  void capturaTieneMastitis(valor){ this._tieneMastitis=valor;}
  void capturaTratamiento(valor){ this._tratamiento=valor;}




  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. ControlVaca"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              //color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    _buildDatoCadena(capturaEtapaDetalle, "EtapaDetalle:"),
                    _buildDatoCadena(capturaFechaProg, "FechaProg:"),
                    _buildDatoFecha(capturaFechaReal,"FechaReal"),
                    _buildDatoCadena(capturaPesoVivo, "PesoVivo:"),
                    _buildDatoCadena(capturaPreno, "Preño:"),
                    _buildDatoCadena(capturaCondicionCorporal, "CondicionCorporal:"),
                    _buildDatoCadena(capturaTieneMastitis, "TieneMastitis:"),
                    _buildDatoCadena(capturaTratamiento, "Tratamiento:"),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                ControlVacaModelo mp = new ControlVacaModelo.unlaunched();
                                mp.etapaDetalle = _etapaDetalle;
                                mp.fechaProg = _fechaProg;
                                //print(DateFormat('yyyy-MM-dd').format(currentTime));
                                mp.fechaReal=DateFormat('yyyy-MM-dd').format(DateTime.parse(_fechaReal.value.text));
                                mp.pesoVivo = _pesoVivo;
                                mp.preno = _preno;
                                mp.condicionCorporal = _condicionCorporal;
                                mp.tieneMastitis = _tieneMastitis;
                                mp.tratamiento = _tratamiento;

                                print(" NA:${_etapaDetalle}, E:${_fechaProg}, "
                                    "F:${_fechaReal} HI:${_pesoVivo} MT:${_preno} "
                                    "La: ${_condicionCorporal}, Lo:${_tieneMastitis} "
                                    "U:${_tratamiento}");

                                var api = await Provider.of<ControlVacaApi>(
                                    context,
                                    listen: false)
                                    .crearControlVaca(TokenUtil.TOKEN,mp);
                                print("ver: ${api.toJson()}");
                                if (api.toJson() !=null) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(Function obtValor,_dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }

  Future<void> _selectDate(BuildContext context, Function obtValor) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        obtValor(selectedDate.toString());
      });
    }
  }
  Widget _buildDatoFecha(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: _fechaReal,
      keyboardType: TextInputType.datetime,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onTap: (){
        _selectDate(context,obtValor);
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }





  Future<bool> permiso() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void>  getCurrentLocation() async {
    final hasPermission = await permiso();
    if (!hasPermission) {
      return;
    }
    if (mounted){
      Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
          .then((Position position) {
        if(mounted){
          setState(() {
            currentPosition = position;
            //getCurrentLocationAddress();
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

}