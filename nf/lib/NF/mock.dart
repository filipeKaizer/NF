import 'package:nf/NF/NF.dart';

List<Nf> data = [
  Nf(
    total: 1000,
    tax: 10,
    qtdProd: 5,
    general: General("16546518", DateTime.now(), 6232923, "Sla", 1),
    emit: Emit("Amazon", "166", "626260959", "62626", Address.none()),
  ),
  Nf(
    total: 2000,
    tax: 23,
    qtdProd: 3,
    general: General("6233", DateTime.now(), 1, "Sdqwd", 1),
    emit: Emit("Google", "13", "6262163", "62213", Address.none()),
  ),
];
