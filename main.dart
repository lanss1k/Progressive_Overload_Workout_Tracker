import 'dart:io';

List<Map<String, dynamic>> workouts = [];

void main() {
  while (true) {
    print("\n===== PROGRESSIVE OVERLOAD WORKOUT TRACKER =====");
    print("1. Add Workout");
    print("2. View Workouts");
    print("3. Delete Workout");
    print("4. Exit");
    stdout.write("Enter choice: ");

    String? choice = stdin.readLineSync();

    if (choice == '1') {
      addWorkout();
    } else if (choice == '2') {
      viewWorkouts();
    } else if (choice == '3') {
      deleteWorkout();
    } else if (choice == '4') {
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

  String progress = checkProgress(exercise, volume);

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
  print("Progress: $progress");
}

String checkProgress(String exercise, double newVolume) {
  for (int i = workouts.length - 1; i >= 0; i--) {
    if (workouts[i]['exercise'] == exercise) {
      double oldVolume = workouts[i]['volume'];

      if (newVolume > oldVolume) {
        return "Improved";
      } else if (newVolume == oldVolume) {
        return "Same";
      } else {
        return "Regressed";
      }
    }
  }
  return "First record for this exercise";
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

void deleteWorkout() {
  stdout.write("Enter ID to delete: ");
  int id = int.parse(stdin.readLineSync()!);

  workouts.removeWhere((w) => w['id'] == id);
  print("Workout deleted if ID existed.");
}