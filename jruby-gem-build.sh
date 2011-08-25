#!/bin/bash

GEM_NAME=$1
JRUBY_JAR=

arquivo="jruby-complete*.jar"

if $(test -f $arquivo); then
	 for i in $(ls $arquivo); 
		 do JRUBY_JAR=$i;
	 done
else
	echo " jruby não existe."
	exit -1
fi

echo "backup jruby jar..."

cp $JRUBY_JAR "$JRUBY_JAR.bak"

echo "installing gems..."

GEM_TEMP="gems-temp"
java -jar $JRUBY_JAR -S gem install -i ./$GEM_TEMP $GEM_NAME

echo 'building file structure...'
META_TEMP="meta-temp"

BIN_PATH="$META_TEMP/META-INF/jruby.home"
GEM_PATH="$META_TEMP/META-INF/jruby.home/lib/ruby/gems/1.8"

mkdir -p $BIN_PATH
mkdir -p $GEM_PATH

cp -r $GEM_TEMP/bin $BIN_PATH 
cp -r $GEM_TEMP/gems $GEM_PATH
cp -r $GEM_TEMP/specifications $GEM_PATH

echo "building jar..."

JAR_NAME="$GEM_NAME-gems-complete.jar"

cp $JRUBY_JAR $JAR_NAME

jar uf $JAR_NAME -C $META_TEMP .

echo 'removing temp gem files...'
rm -r $GEM_TEMP
rm -r $META_TEMP

echo "restoring jruby-jar"

mv "$JRUBY_JAR.bak" $JRUBY_JAR 
