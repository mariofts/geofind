#!/bin/bash

#JRUBY_JAR=$1
#VRAPTOR_JAR="vraptor-scaffold-complete.jar"

echo "installing gems..."

#GEM_TEMP="gems-temp"
#java -jar $JRUBY_JAR -S gem install -i ./$GEM_TEMP vraptor-scaffold

echo 'building file structure...'
#META_TEMP="meta-temp"

#BIN_PATH="$META_TEMP/META-INF/jruby.home"
#GEM_PATH="$META_TEMP/META-INF/jruby.home/lib/ruby/gems/1.8"

#mkdir -p $BIN_PATH
#mkdir -p $GEM_PATH

#cp -r $GEM_TEMP/bin $BIN_PATH 
#cp -r $GEM_TEMP/gems $GEM_PATH
#cp -r $GEM_TEMP/specifications $GEM_PATH

echo "building jar..."
#cp $JRUBY_JAR $VRAPTOR_JAR

#jar uf $VRAPTOR_JAR -C $META_TEMP .


echo 'removing temp gem files...'
#rm -r $GEM_TEMP
#rm -r $META_TEMP



