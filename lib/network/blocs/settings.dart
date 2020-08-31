



class SettingsBloc {
//		final BehaviorSubject<Settings> _subject = BehaviorSubject<Settings>();
//
//
//		getSettings() async {
//				//ResponseSettings response = await SettingsApi().getSettings();
//
//				_subject.sink.add(response.data);
//		}
//
//		updateSettings(Settings settings) {
//
//				_subject.sink.add(settings);
//		}
//
//		dispose() {
//				_subject.close();
//		}
//
//		BehaviorSubject<Settings> get subject => _subject;
}
final settingsBloc = SettingsBloc();