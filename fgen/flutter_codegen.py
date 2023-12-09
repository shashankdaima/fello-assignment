import argparse
import subprocess
import os
import json
import re
from screen_and_vm_gen import screen_and_vm_gen

def to_camel_case(text):
    # Convert snake_case to camelCase
    return ''.join(word.title() if i > 0 else word for i, word in enumerate(text.split('_')))

def to_snake_case(text):
    # Convert camelCase to snake_case
    return re.sub(r'(?<!^)(?=[A-Z])', '_', text).lower()

def generate_flutter_screen(screen_name):
    # Generate Flutter screen files, widgets, providers, etc.
    presentation_dir ="lib/presentation/"
    # Create a sub-directory with the screen name
    screen_dir = os.path.join(presentation_dir, screen_name)
    os.makedirs(screen_dir, exist_ok=True)

    # Define file names
    filename = screen_name.lower()  # You may need to adjust this to your naming convention
    dart_file = os.path.join(screen_dir, f"{filename}.dart")
    vm_file = os.path.join(screen_dir, f"{filename}_vm.dart")

    screen_and_vm_gen(screen_name)

def update_router_file(screen_name):
    # Modify the Flutter router file (e.g., lib/app_routes.dart) to include the new screen.
    router_file_path="lib/core/app_router.dart"
    print(f"Updating router file for {screen_name}")

def run_build_runner():
    # Run 'flutter packages pub run build_runner build' using subprocess.
    print("Running build_runner")
    subprocess.run(["dart", "run", "build_runner", "build"])

def main():
    parser = argparse.ArgumentParser(description='Generate Flutter screen and run build_runner')
    parser.add_argument('-n', '--name', help='Name of the Flutter screen')
    parser.add_argument('-B', '--build', action='store_true', help='Run build_runner')
    args = parser.parse_args()

    if args.build:
        run_build_runner()
    elif (args.name):
        screen_name = args.name
        generate_flutter_screen(screen_name)
        update_router_file(screen_name)
        run_build_runner()


if __name__ == "__main__":
    main()
