import 'dart:io';

List<Map<String, dynamic>> workouts = [];

void main() {
  while (true) {
    print("\n===== PROGRESSIVE OVERLOAD WORKOUT TRACKER =====");
    print("1. Add Workout");
    print("2. View Workouts");
    print("3. Update Workout");
    print("4. Delete Workout");
    print("5. Exit");
    stdout.write("Enter choice: ");

    String? choice = stdin.readLineSync();

    if (choice == '1') {
      addWorkout();
    } else if (choice == '2') {
      viewWorkouts();
    } else if (choice == '3') {
      updateWorkout();
    } else if (choice == '4') {
      deleteWorkout();
    } else if (choice == '5') {
      print("Program ended.");
      break;
    } else {
      print("Invalid choice.");
    }
  }
}

void addWorkout() {
  stdout.write("Workout ID: ");
  int id = int.parse(stdin.readLineSync()!);

  stdout.write("Exercise Name: ");
  String exercise = stdin.readLineSync()!;

  stdout.write("Sets: ");
  int sets = int.parse(stdin.readLineSync()!);

  stdout.write("Reps: ");
  int reps = int.parse(stdin.readLineSync()!);

  stdout.write("Weight (kg): ");
  double weight = double.parse(stdin.readLineSync()!);

  double volume = sets * reps * weight;

  workouts.add({
    'id': id,
    'exercise': exercise,
    'sets': sets,
    'reps': reps,
    'weight': weight,
    'volume': volume
  });

  print("\nWorkout saved.");
  print("Total Volume: $volume");
}

void viewWorkouts() {
  if (workouts.isEmpty) {
    print("No workouts recorded.");
    return;
  }

  print("\n=== Workout Records ===");
  for (var w in workouts) {
    print("ID: ${w['id']}");
    print("Exercise: ${w['exercise']}");
    print("Sets: ${w['sets']}  Reps: ${w['reps']}  Weight: ${w['weight']} kg");
    print("Volume: ${w['volume']}");
    print("---------------------------");
  }
}

void updateWorkout() {
  stdout.write("Enter ID to update: ");
  int id = int.parse(stdin.readLineSync()!);

  for (var w in workouts) {
    if (w['id'] == id) {
      double oldVolume = w['volume'];

      stdout.write("New Sets: ");
      w['sets'] = int.parse(stdin.readLineSync()!);

      stdout.write("New Reps: ");
      w['reps'] = int.parse(stdin.readLineSync()!);

      stdout.write("New Weight (kg): ");
      w['weight'] = double.parse(stdin.readLineSync()!);

      double newVolume = w['sets'] * w['reps'] * w['weight'];
      w['volume'] = newVolume;

      print("Workout updated.");

      if (newVolume > oldVolume) {
        print("Progress: Improved");
      } else if (newVolume == oldVolume) {
        print("Progress: Same");
      } else {
        print("Progress: Regressed");
      }

      return;
    }
  }

  print("Not a valid choice.");
}

void deleteWorkout() {
  stdout.write("Enter ID to delete: ");
  int id = int.parse(stdin.readLineSync()!);

  int initialLength = workouts.length;
  workouts.removeWhere((w) => w['id'] == id);

  if (workouts.length == initialLength) {
    print("Not a valid choice.");
  } else {
    print("Workout deleted.");
  }
}