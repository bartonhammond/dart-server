import 'package:server/model/user.dart';
import 'package:server/server.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:server/server.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

/// A testing harness for server.
///
/// A harness for testing an aqueduct application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("Make request", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<ServerChannel> with TestHarnessAuthMixin<ServerChannel>, TestHarnessORMMixin {
  @override
  ManagedContext get context => channel.context;

  @override
  AuthServer get authServer => channel.authServer;

  Agent publicAgent;

  @override
  Future onSetUp() async {
    // add initialization code that will run once the test application has started
    await resetData();

    publicAgent = await addClient("com.aqueduct.public");
  }

  Future<Agent> registerUser(User user, {Agent withClient}) async {
    withClient ??= publicAgent;

    final req = withClient.request("/register")
      ..body = {"username": user.username, "password": user.password};
    await req.post();

    return loginUser(withClient, user.username, user.password);
  }
}