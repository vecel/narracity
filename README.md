# Narracity

## Initial Documentation

### Description

A Narracity is an application that enhace sightseeing experience. It offers various narrator-leaded scenarios. They can be used to create sightseeing city tours, role playing games or onboarding trips.

**Optional Requirements**
1. Unit tests,
2. Wdiget tests,
3. Patrol tests,
4. Target Web,
5. CI/CD,
6. Platform channel (device localization),
7. Local data persistance,
8. Internalization.

**User Stories**
1. As a user, I can see list of available scenarios.
2. As a user, I can start a scenario.
3. As a user, I can download the scenario to use it offline.
4. As a user, I can play the scenario. This includes:
- I can see narrators' speech.
- I can make choices when such option appears.
- I can respond to narrator's questions.
- The zone to be reached is displayed on the map.
- My location is being updated on the map.
- My "play character" can get specific scenario related items, thoughts or skills in journal.

## Final documentation

### Description

Narracity is a location-based storytelling application built with Flutter. It allows users to explore cities through interactive "scenarios" (tours, games, or educational walks).

**Platform:** Android.

**Key Capabilities:**
1. Easy to write scenario: Scenario definition is easy to create by anyone by enhancing usage of custom DSL. It offers an API with concise, flutter-like syntax that allows creating a scenario by writing a ```dart``` program. This program is then parsed to proper json structure, that is used by application.

2. Graph based navigation: Users move through a scenario node-by-node, triggered by UI interactions or GPS location. With that scenarios could be played in different, nonlinear ways, allowing users to make their own choices and experience their consequences in the game.

3. Offline usage: Scenarios are primarly fetched from Firebase Firestore, but they can be saved to offline usage from disk files. Then users can play a game without internet connection.

> Uploading scenario is not implemented and was not meant to within the projects' scope.

> In the current version user still needs internet connection to see the map.

### Integrations
The application integrates with the following external libraries and services:
1. **Go Router:** Application routing,
2. **Flutter Bloc:** State management of the application,
3. **Firebase Firestore:** Primary cloud database for storing scenario metadata and node subcollections,
4. **Firebase Core:** App initialization and configuration,
5. **Json Serializable:** For robust serialization of DSL objects,
6. **Geolocator:** Used for handling user's position and location permissions,
7. **Flutter Map:** For displaying layered map view,
8. **Logging:** Custom, configurable log messages,
9. **Patrol:** Used for integration testing,
10. **Mocktail:** For robust testing.


### Fulfilled Optional Requirements
1. Unit, Widget and Patrol tests,
2. Firebase anonymous authorization,
3. CI/CD with static code analysis report, tests and deployment when tests pass,
4. Android's platform channel: location,
5. Local data persistence.

### Installation
Go to **Issues** section inside the repository and download the APK file from issue ```Release APK```. Connect your Android Device to the computer and allow USB debugging. Move downloaded APK file to ```Downloads``` directory of your phone. Then open ```File Explorer``` on the phone and install the application.

Or install directly from source. Instructions below.

**Preresquities**
1. Flutter SDK (latest stable),
2. Dart SDK (version at least 3.9.2),
3. Android Device.

**Setup**

**Clone the repository:**
```bash
git clone https://github.com/vecel/narracity.git
cd narracity
```

**Install dependencies:**
```bash
flutter pub get
```

**Generate Serialization Code:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Install**

Attach your device to the computer and allow USB debugging. Make sure it is visible (eg. by VS Code), so you can install an app on it. Then run:
```bash
flutter install --device-id <Your Device ID>
```


### Firebase Firestore Schema
**Collection** ```scenarios``` :
- Path: ```scenarios/<Scenario ID>```
- Fields:
    - ```id``` string - The ID of the scenario,
    - ```title``` string - Scenario title,
    - ```description``` string - Scenario description,
    - ```distance``` string - Estimated distance to be walked while playing the scenario,
    - ```duration``` string - Estimated time to complete scenario,
    - ```location``` string - The place where scenario plays,
    - ```image``` string - Url of scenario's thumbnail,
    - ```startNodeId``` string - The ID of the first scenario node.

**Subcollection** ```nodes```:
- Path: ```scenarios/<Scenario ID>/nodes/<Node ID>```
- Fields:
    - ```id``` string - Node's ID,
    - ```elements``` list - A list of serialized DSL ScenarioElement objects.


### CI/CD Setup
Project's CI/CD pipeline is set up with Github Actions. It is available under the link: https://github.com/vecel/narracity/actions/workflows/flutter_ci.yaml.

On each pull and push request the following operations are performed:
1. Application setup and build,
2. Static code analysis with a report uploaded to ```txt``` file. This step does not break the pipeline,
3. Unit tests. If any test fails, the pipeline is stopped.
4. Application APK build and upload.

### Demo Film
![Demo film of Narracity application](https://github.com/user-attachments/assets/677c06f6-3b07-456c-886d-3a220ef9ccaa)

---

*This is a project created for Programming Mobile Apps  With Flutter Course at Warsaw University of Technology 2025/26.*
