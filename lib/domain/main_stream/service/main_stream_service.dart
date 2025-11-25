abstract class MainStreamService {
  Stream<MainStreamEvent> getStream();

  void add(MainStreamEvent event);
}

class MainStreamEvent {}
