#!/bin/bash

# copy the configuration folder to tmp to be writable
tmp_dir="$(mktemp -d /tmp/jdtls.XXXXX)"
cp -R /usr/share/java/jdtls/config_linux "${tmp_dir}"
# and ensure that it is removed on exit
trap "{ rm -rf ${tmp_dir}; }" EXIT

JAR="/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle /usr/lib/jvm/java-11-openjdk/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "${tmp_dir}/config_linux" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
