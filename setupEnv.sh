#!/bin/sh

# Get lockss-daemon source
echo "Initializing lockss-daemon..."
git clone https://github.com/lockss/lockss-daemon.git

echo "Building LOCKSS jars...\n"

# Build LOCKSS JARs and put into local Maven repository
cd lockss-daemon
git checkout snafl-changes
ant jar-lockss
ant jar-plugins

# make sure we install the missing mvn jars the lockss libs we use

echo "Installing LOCKSS jars to maven repo...\n"
mvn install:install-file -Dfile=lib/lockss.jar -DpomFile=/poms/lockss-2016.pom 
mvn install:install-file -Dfile=lib/lockss-plugins.jar -DpomFile=/poms/lockss-plugins-2016.pom

echo "Installing old or patched jars to maven repo...\n"

# - this is the pre-apache verision of the derby jars
mvn install:install-file -Dfile=lib/derby.jar -DpomFile=/poms/derby-9.1.pom
mvn install:install-file -Dfile=lib/derbyclient.jar -DpomFile=/poms/derbyclient-9.1.pom
mvn install:install-file -Dfile=lib/derbynet.jar -DpomFile=/poms/derbynet-9.1.pom

# these are patched versions of older libs
mvn install:install-file -Dfile=lib/heritrix-commons-3.1.0-p1.jar -DpomFile=/poms/heritrix-commons-3.1.0-p1.pom
mvn install:install-file -Dfile=lib/htmlparser-1.6p.jar -DpomFile=/poms/htmlparser-1.6p.pom
mvn install:install-file -Dfile=lib/jetty-5.1.5L.jar -DpomFile=/poms/jetty-5.1.5L.pom
mvn install:install-file -Dfile=lib/JimiProClasses.jar -DpomFile=/poms/JimiProClasses.pom
mvn install:install-file -Dfile=lib/JoSQL-2.2.jar -DpomFile=/poms/JoSQL-2.2.pom
mvn install:install-file -Dfile=lib/oiosaml.java-21188-PATCHED.jar -DpomFile=/poms/oiosaml.java-21188-PATCHED.pom
mvn install:install-file -Dfile=lib/PDFBox-0.7.3.jar -DpomFile=/poms/PDFBox-0.7.3.pom
mvn install:install-file -Dfile=lib/rdf-api-2001-01-19.jar -DpomFile=/poms/rdf-api-2001-01-19.pom

# run maven build and test
echo "Running build and tests..."
mvn clean package
