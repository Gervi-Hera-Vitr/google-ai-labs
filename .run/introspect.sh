#!/usr/bin/env zsh
setopt RCS LOGIN

source "$HOME/.zprofile"
source "$HOME/.zshenv"
 # shellcheck source=SDKMAN_INIT
[[ -s "$SDKMAN_INIT" ]] && source "$SDKMAN_INIT"

_outside_actions=false

if [ -z "${GITHUB_ENV+xxx}" ]; then
  echo -e "WARNING: GITHUB_ENV !! file !! is NOT set!\n... exporting.";
  export GITHUB_ENV="";
else
  echo -e "GITHUB_ENV File is: $GITHUB_ENV";
fi


if [ -z "$GITHUB_ENV" ] && [ "${GITHUB_ENV+xxx}" = "xxx" ]; then
  echo -e "\nWARNING:\n\tGITHUB_ENV is set but empty!\n... creating.\n";
  local_temp_folder="$HOME/tmp";
  mkdir -p "$local_temp_folder";
  export GITHUB_ENV="$local_temp_folder/github_env.local";
  echo -e "GITHUB_ENV File is: $GITHUB_ENV";
fi

cat <<EOF

======================== Introspection ========================
| Checking Agent for local Java and Gradle installations      |
|                                                             |
| Expecting the following environment SDKs to be installed:   |
| - JDK:    21 Temurin                                        |
| - Gradle: 8.10                                              |
| ------------------------------------------------------------|
|
EOF

# Check for Java 21.0
JAVA_VERSION_INSTALLED=$(java -version 2>&1 | grep -o '21\.0' | head -1)
echo -e "| Java version installed:   \t$JAVA_VERSION_INSTALLED"
if [[ $JAVA_VERSION_INSTALLED =~ 21.0 ]]; then
  echo "java_correct=true" >> "$GITHUB_ENV"
  echo -e "| Java 21: \t\t\tOK"
else
  echo "java_correct=false" >> "$GITHUB_ENV"
  echo -e "| Java 21: \t\t\tFAILED"
fi
echo "| ------------------------------------------------------------|"

# Check for Gradle 8.10
GRADLE_VERSION_INSTALLED=$(gradle --version 2>&1 | grep -o '8\.10')
echo -e "| Gradle version installed: \t$GRADLE_VERSION_INSTALLED"
if [[ $GRADLE_VERSION_INSTALLED =~ 8.10 ]]; then
  echo "gradle_correct=true" >> "$GITHUB_ENV"
  echo -e "| Gradle 8.10: \t\t\tOK"
else
  echo "gradle_correct=false" >> "$GITHUB_ENV"
  echo -e "| Gradle 8.10: \t\t\tFAILED"
fi
echo "| ------------------------------------------------------------|"
echo "| ${GITHUB_ENV}"
echo "==============================================================="
echo -e "File contents:\n"
cat "$GITHUB_ENV"
exit 0
