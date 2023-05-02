#!/bin/bash
cd ./open-sources && cd cli_dialog &&  git checkout main  && git add .   &&  git commit -am "clean-up" && git push origin main
cd .. && cd dart_console &&  git checkout main  && git add .   && git commit -am "clean-up" && git push origin main
cd .. && cd flutter.widgets &&  git checkout main  && git add . && git commit -am "clean-up" && git push origin main
# cd .. && cd open_file &&  git checkout main && git commit -am "clean-up" && git push origin main
cd .. && cd qr.flutter &&  git checkout main  && git add . && git commit -am "clean-up" && git push origin main
cd .. && cd receipt &&  git checkout main  && git add .   && git commit -am "clean-up" && git push origin main
cd .. && cd dart_pdf &&  git checkout main  && git add . && git commit -am "clean-up" && git push origin main
cd .. && cd kds &&  git checkout master  && git add . && git commit -am "clean-up" && git push origin master
cd .. && cd qr_code_scanner &&  git checkout master  && git add . && git commit -am "clean-up" && git push origin master
cd .. && cd pubnub &&  git checkout master  && git add . && git commit -am "clean-up" && git push origin master
cd .. && cd upgrader &&  git checkout master  && git add . && git commit -am "clean-up" && git push origin master
cd .. && cd system_time_check &&  git checkout main  && git add . && git commit -am "clean-up" && git push origin main
cd .. && cd flutter_file_picker &&  git checkout master  && git add . && git commit -am "clean-up" && git push origin master
cd .. && cd animated_toggle_switch &&  git checkout  && git add .  && git commit -am "clean-up" && git push origin main
cd .. && cd animated_toggle_switch &&  git checkout  && git add .  && git commit -am "clean-up" && git push origin main
cd .. && cd flutter_list_drag_and_drop &&  git checkout main  && git add .  && git commit -am "clean-up" && git push origin main
cd .. && cd flutterfire_desktop &&  git checkout main  && git add .  && git commit -am "clean-up" && git push origin main
cd .. && cd plus_plugins &&  git checkout main  && git add .  && git commit -am "clean-up" && git push origin main
cd .. && cd flutter_slidable &&  git checkout dev  && git add .  && git commit -am "clean-up" && git push origin dev
cd .. && cd money_formatter &&  git checkout dev  && git add .  && git commit -am "clean-up" && git push origin dev
cd .. && cd flutter_launcher_icons &&  git checkout master  && git add .  && git commit -am "clean-up" && git push origin master
cd .. && cd flutter_datetime_picker &&  git checkout master  && git add .  && git commit -am "clean-up" && git push origin master
cd .. && cd flutter_luban  &&  git checkout master  && git add .  && git commit -am "clean-up" && git push origin master

# These dependencies where local and now depend on them from pubspec
# I was doing it becase it was using permissions that were not accepted but now I believe they are removed.
#dart_pdf
# flutter_file_picker
