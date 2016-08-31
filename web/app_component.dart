import 'package:angular2/core.dart';

import 'package:force/force_browser.dart';
import 'package:cargo/cargo_client.dart';

import 'lib/hunt.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html')
class AppComponent implements OnInit {
  String name = "";
  String url = "";
  int point = 0;

  String error = "";

  /** Force specific **/
  ForceClient forceClient;
  ViewCollection hunts;

  void ngOnInit() {
    forceClient = new ForceClient();
    forceClient.connect();

    forceClient.onConnected.listen((ConnectEvent ce) {
        hunts = forceClient.register("simple", new Cargo(MODE: CargoMode.MEMORY));
    });

    forceClient.on("notify", (message, sender) {
      error = message.json;
    });
  }

  void update(key, value) {
    var hunt = new Hunt.fromJson(value);
    hunt.point += 1;

    hunts.update(key, hunt);
  }

  void send() {
    if(name != "" && url != "") {
      hunts.set(new Hunt(name, url).toJson());
      // reset error field
      error = "";
    }
  }
}
