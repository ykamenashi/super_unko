#!/bin/bash

__THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%N}}")"; pwd)"

TARGET_COMMAND="${__THIS_DIR}/../bin/unko.toilet"

# message [name] [status]
# statusが0ならOKを出力してreturn、 それ以外ならNGを出力してexit 1
function message() {
  name="$1"
  status="$2"
  expect="$3"
  
  [[ "$status" == "$3" ]] && echo "[OK] $name" && return 0

  echo "[NG] $name" 
  exit 1
}

function EQ() {
  name="$1"
  expect="$2"
  actual="$3"

  [[ "$expect" == "$actual" ]] 

  message $name $? 0
}

function OK() {
  name="$1"
  shift
  cmd="$@"

  $cmd &> /dev/null
  message $name $? 0
}

function NG() {
  name="$1"
  shift
  cmd="$@"

  $cmd &> /dev/null
  message $name $? 1
}

OK "普通に実行" "$TARGET_COMMAND"
NG "おかしなオプション--お菓子" "$TARGET_COMMAND --お菓子"

HANAGE_BASE64="ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAg
ICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIPCfkqkgICAg8J+SqSAg
8J+SqSAgICAKICDwn5KpICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgIPCfkqkgIPCf
kqkgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICDwn5KpICDwn5KpICDwn5KpICAgIAogICAg
8J+SqSAg8J+SqSAgICAgIPCfkqnwn5Kp8J+SqSAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqfCfkqkg
IPCfkqnwn5KpICAgICAgICAgICAgICDwn5KpICAgICAgICAgIPCfkqnwn5Kp8J+SqSAgICAgIAog
ICAg8J+SqSAgICDwn5Kp8J+SqfCfkqnwn5KpICAgICAgICAgICAgICAgIPCfkqkgICAgICAgIPCf
kqnwn5KpICAgICAgICAgICAg8J+SqSAg8J+SqfCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgCiAg
8J+SqSAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAg8J+SqSAgICAgIPCfkqkgICAgICAg
ICAgICAgIPCfkqkgICAgICAgICAgICDwn5KpICAgICAgICAgIAogIPCfkqkgICAgICAgICAgICDw
n5KpICAgICAgICAgICAgICDwn5KpICAgICAgICDwn5KpICAgICAgICAgICAgICDwn5KpICAgICAg
ICAgICAg8J+SqSAgICAgICAgICAKICDwn5KpICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAg
8J+SqSAgICAgICAg8J+SqSAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgIPCfkqkgICAgICAg
ICAgCiAg8J+SqSAgICAgIPCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgICDwn5KpICAgIPCfkqnw
n5Kp8J+SqfCfkqkgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICDwn5KpICAgICAgICAgIAog
IPCfkqkgIPCfkqnwn5KpICAgICAg8J+SqfCfkqkgICAgICAgICAgICAgIPCfkqkgICAgICDwn5Kp
8J+SqSAgICAgICAgICAgICAg8J+SqfCfkqkgICAgICDwn5KpICAgICAgICAgICAgCiAg8J+SqfCf
kqkgIPCfkqkgICAgICDwn5KpICDwn5KpICAgICAgICAgICAg8J+SqSAgICAgIPCfkqkgIPCfkqkg
ICAgICAgICAgICDwn5KpICAgICAgICDwn5KpICAgICAgICAgICAgCiAgICDwn5KpICAgIPCfkqnw
n5Kp8J+SqSAgICAgICAgICAgICAgICAgICAg8J+SqfCfkqnwn5KpICAgICAgICAgICAgICAgICAg
ICAgICAgICDwn5KpICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK"

EQ "stdinから" "$(echo はなげ|$TARGET_COMMAND|base64)" "$HANAGE_BASE64"
EQ "引数に" "$($TARGET_COMMAND はなげ|base64)" "$HANAGE_BASE64"

EQ "flip" "$($TARGET_COMMAND --flip|base64)" "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIPCfkqnwn5KpICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgICAgICDwn5Kp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICDwn5Kp8J+SqfCf
kqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAg
ICAg8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgCiAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICDwn5Kp
8J+SqSAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIPCf
kqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgIPCfkqkg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAg
ICAgICDwn5Kp8J+SqfCfkqkgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgIPCfkqkgICAg
ICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAKICAgICAgICDwn5KpICAgICAgICAgIPCf
kqkgICAgICAgICAgICDwn5KpICAgICAg8J+SqSAgICAgIPCfkqkgICAgICAgICAgICAgICAg8J+S
qSAgICAgICAgICAgICAgCiAgICAgICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgICAg
ICAgICDwn5KpICAgIPCfkqkgICAgICDwn5KpICAgICAgICAgICAgICAgICAg8J+SqSAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIPCfkqnwn5KpICAgICAg
ICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAo="

EQ "flop" "$($TARGET_COMMAND --flop|base64)" "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAg
ICDwn5KpICAgICAgICAgIPCfkqnwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgIPCfkqkgICAgICDwn5KpICAg
IPCfkqkgICAgICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgCiAgICAg
ICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICDwn5KpICAgICAg8J+SqSAgICAgIPCfkqkgICAg
ICAgICAgICDwn5KpICAgICAgICAgIPCfkqkgICAgICAgIAogICAgICAgICAgICAgIPCfkqkgICAg
ICAgICAgICAgICAgICDwn5KpICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICDwn5Kp8J+S
qfCfkqkgICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAg
ICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAg8J+SqfCfkqkgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgCiAgICAgICAg8J+SqfCfkqnw
n5Kp8J+SqSAgICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgICAgICAg
8J+SqfCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgIPCfkqnwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgIPCfkqkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAo="

EQ "180" "$($TARGET_COMMAND --180|base64)" "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICDwn5Kp8J+SqSAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAg8J+SqSAgICAg
ICAgICAKICAgICAgICAgIPCfkqnwn5Kp8J+SqfCfkqnwn5KpICAgICAgICAgICAgICAgIPCfkqkg
ICAg8J+SqSAgICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgCiAgICAg
ICAg8J+SqSAgICAgICAgICDwn5KpICAgICAgICAgICAg8J+SqSAgICAgIPCfkqkgICAgICDwn5Kp
ICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg
8J+SqSAgICAgICAgICAgICAgICAgIPCfkqkgICAg8J+SqSAgICAgICAgICAgICAgICAgIPCfkqkg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAg
ICAg8J+SqfCfkqnwn5KpICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAg
ICAgICAg8J+SqSAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAg
IAogICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg8J+SqSAgICAg
ICAgICAgICAgICAgICAg8J+SqSAgICAgICAg8J+SqfCfkqkgICAgCiAgICAgICAgICDwn5Kp8J+S
qfCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAg
ICAgICAg8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgCiAgICAgICAgICAgICAgICAgICAg8J+SqSAg
ICAgICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIPCfkqnwn5KpICAgICAgICAgIAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIPCf
kqkgICAgICAgIAo="

EQ "right" "$($TARGET_COMMAND --right|base64)" "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDwn5Kp8J+SqSAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAg8J+SqfCfkqkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAg8J+SqfCfkqkgICAg8J+SqfCfkqnwn5Kp8J+SqQogICAgICAgICAgICAgICAg8J+SqfCfkqnw
n5Kp8J+SqfCfkqnwn5KpICAgICAgICAgICAgICAgIPCfkqnwn5KpICAgIPCfkqnwn5KpICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCf
kqkgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAg8J+SqfCfkqkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg8J+SqfCf
kqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+S
qfCfkqnwn5Kp8J+SqfCfkqkgICAgICAgIAogICAgICAgICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+S
qfCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
IPCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAg8J+SqfCfkqkgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgIPCfkqnwn5Kp8J+SqfCfkqnwn5Kp
8J+SqSAgICAgICAgICAgICAgICDwn5Kp8J+SqSAgICAgICAgCiAgICAgICAgICAgICAgICDwn5Kp
8J+SqSAgICAgICAgICAgICAgICAgICAgICAgIPCfkqnwn5KpICAgICAgICAgICAgCiAgICAgICAg
ICAgICAgICDwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqSAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAg
ICAg8J+SqfCfkqkgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo="


EQ "left" "$($TARGET_COMMAND --left|base64)" "ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICDwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAg8J+SqfCfkqnw
n5Kp8J+SqSAgICAgICAgICAgICAgICAKICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqSAgICAg
ICAgICAgICAgICAgICAg8J+SqfCfkqkgICAgICAgICAgICAgICAgCiAgICAgICAgICAgIPCfkqnw
n5KpICAgICAgICAgICAgICAgICAgICAgICAg8J+SqfCfkqkgICAgICAgICAgICAgICAgCiAgICAg
ICAg8J+SqfCfkqkgICAgICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5KpICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICDwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICDwn5Kp8J+SqfCfkqnwn5KpICAgICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAg8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqkgICAgICAg
ICAgICAKICAgICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+S
qfCfkqkgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDwn5Kp8J+SqSAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp
8J+SqSAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgIPCfkqnwn5KpICAgIPCfkqnwn5Kp
ICAgICAgICAgICAgICAgIPCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAK
8J+SqfCfkqnwn5Kp8J+SqSAgICDwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAgICAgICAgICDw
n5Kp8J+SqSAgICAgICAgICAgIAogICAgICAgICAgICAgICAg8J+SqfCfkqkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo="

EQ "border" "$($TARGET_COMMAND --border|base64)" "8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnw
n5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCf
kqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+S
qfCfkqkK8J+SqSAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg8J+SqQrwn5KpICAgICAgICAg
IPCfkqnwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIPCfkqkK8J+SqSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAg
ICAgICDwn5KpCvCfkqkgICAgICAgIPCfkqnwn5Kp8J+SqfCfkqkgICAgICAgICAgICAgICAgICAg
ICAg8J+SqSAgICAgICAgICAgICAgICAgICAgICAgIPCfkqnwn5Kp8J+SqfCfkqnwn5KpICAgICAg
ICAgIPCfkqkK8J+SqSAgICDwn5Kp8J+SqSAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgICAg
8J+SqSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICDwn5KpCvCf
kqkgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg8J+SqQrwn5KpICAgICAgICAgICAgICAg
IPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIPCfkqkK8J+SqSAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAg
ICAgIPCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICAg
ICAgICDwn5KpCvCfkqkgICAgICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAg
IPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgICAgIPCfkqkK8J+S
qSAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgICAgICDwn5KpICAgICAg8J+SqSAgICAgIPCf
kqkgICAgICAgICAgICDwn5KpICAgICAgICAgIPCfkqkgICAgICAgIPCfkqkK8J+SqSAgICAgICAg
ICAgIPCfkqkgICAgICAgICAgICAgICAgICDwn5KpICAgICAg8J+SqSAgICDwn5KpICAgICAgICAg
ICAgICAgIPCfkqnwn5Kp8J+SqfCfkqnwn5KpICAgICAgICAgIPCfkqkK8J+SqSAgICAgICAgICDw
n5KpICAgICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICDwn5Kp8J+SqSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAg8J+SqQrwn5KpICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAg8J+SqQrwn5KpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg8J+SqQrwn5KpICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAg8J+SqQrwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCf
kqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+S
qfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp
8J+SqfCfkqnwn5Kp8J+SqfCfkqnwn5Kp8J+SqQo="

WIDTH_20="ICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgCiAgICAgICAgICDwn5Kp8J+SqSAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICDwn5Kp8J+SqfCfkqnw
n5KpICAgICAgICAgICAgCiAgICDwn5Kp8J+SqSAgICAgICAg8J+SqSAgICAgICAgICAKICAgICAg
ICAgICAgICAgIPCfkqkgICAgICAgICAgCiAgICAgICAgICAgICAgICDwn5KpICAgICAgICAgIAog
ICAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAKICAgICAgICAgICAgICDwn5KpICAgICAgICAg
ICAgCiAgICAgICAgICAgICAg8J+SqSAgICAgICAgICAgIAogICAgICAgICAgICDwn5KpICAgICAg
ICAgICAgICAKICAgICAgICAgIPCfkqkgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgIPCfkqkgICAgICAgICAgICAgICAgICAKICAgICAgICAgIPCf
kqkgICAgICAgICAgICAgICAgCiAgICAgICAgICDwn5KpICAgICAgICAgICAgICAgIAogICAgICAg
IPCfkqkgICAgICAgICAgICAgICAgICAKICAgICAgICDwn5KpICAgICAgICAgICAgICAgICAgCiAg
ICAgIPCfkqnwn5Kp8J+SqSAgICAgICAgICAgICAgICAKICAgICAg8J+SqSAgICDwn5KpICAgICAg
ICAgICAgICAKICAgIPCfkqkgICAgICDwn5KpICAgICAg8J+SqSAgICAgIAogICAg8J+SqSAgICAg
IPCfkqkgICAg8J+SqSAgICAgICAgCiAg8J+SqSAgICAgICAgICDwn5Kp8J+SqSAgICAgICAgICAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgIPCfkqkgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgIPCfkqnwn5Kp8J+SqfCfkqnwn5KpICAgICAgICAgIAogICAgICAgICAgICAg
IPCfkqkgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICDwn5KpICAgICAgICAgICAgICAgICAgICAgIAogICAg8J+S
qSAgICAgICAgICAgICAgICAgICAgICAKICAgICAg8J+SqSAgICAgICAgICDwn5KpICAgICAgICAK
ICAgICAgICDwn5Kp8J+SqfCfkqnwn5Kp8J+SqSAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo="

EQ "-w20" "$($TARGET_COMMAND -w 20|base64)" "$WIDTH_20"
EQ "--width20" "$($TARGET_COMMAND --width 20|base64)" "$WIDTH_20"

NG "--help" "$TARGET_COMMAND --help"
NG "-h" "$TARGET_COMMAND -h"
EQ "--help==-h" "$($TARGET_COMMAND --help 2>&1)" "$($TARGET_COMMAND -h 2>&1)"
EQ "ヘルプメッセージは正しいかな？" "$($TARGET_COMMAND --help 2>&1 | base64)" "VXNhZ2U6IHVua28udG9pbGV0IFsgLWh2IF0gWyAtdyBvdXRwdXR3aWR0aCBdCiAgICAgICAgICAg
ICAgICAgICBbIC0tY3JvcCBdIFsgLS1mbGlwIF0gWyAtLWZsb3AgXQogICAgICAgICAgICAgICAg
ICAgWyAtLTE4MCBdIFsgLS1sZWZ0IF0gWyAtLXJpZ2h0IF0KICAgICAgICAgICAgICAgICAgIFsg
LS1ib3JkZXIgXSBbIG1lc3NhZ2UgXQoKICAtaCwgLS1oZWxwICAgICAgICAgICAgICAgICAg44GT
44Gu44OY44Or44OX44KS5Ye65Yqb44GX44Gm57WC5LqG44GX44G+44GZCiAgLXcsIC0td2lkdGgg
PHdpZHRoLCBhdXRvPiAgIOWHuuWKm+OBruW5heOBp+OBmeOAgmF1dG/jgpLmjIflrprjgZnjgovj
gajnq6/mnKvjga7luYXjgavjgarjgorjgb7jgZkKICAgICAgLS1jcm9wICAgICAgICAgICAgICAg
ICAg5LiK5LiL5bem5Y+z44Gu54Sh6aeE44Gq44K544Oa44O844K544KS5YmK6Zmk44GX44G+44GZ
CiAgICAgIC0tZmxpcCAgICAgICAgICAgICAgICAgIOawtOW5s+aWueWQkeOBq+WPjei7ouOBl+OB
vuOBmQogICAgICAtLWZsb3AgICAgICAgICAgICAgICAgICDlnoLnm7TmlrnlkJHjgavlj43ou6Lj
gZfjgb7jgZkKICAgICAgLS0xODAgICAgICAgICAgICAgICAgICAgMTgw5bqm5Zue6Lui44GX44G+
44GZCiAgICAgIC0tbGVmdCAgICAgICAgICAgICAgICAgIOW3puOBuDkw5bqm5Zue6Lui44GX44G+
44GZCiAgICAgIC0tcmlnaHQgICAgICAgICAgICAgICAgIOWPs+OBuDkw5bqm5Zue6Lui44GX44G+
44GZCiAgICAgIC0tYm9yZGVyICAgICAgICAgICAgICAgIOaeoOe3muOCkuOBpOOBkeOBvuOBmQoK"

OK "--version" "$TARGET_COMMAND --version"
OK "-v" "$TARGET_COMMAND -v"
EQ "--version==-v" "$($TARGET_COMMAND --version)" "$($TARGET_COMMAND -v)"
EQ "バージョン情報は正しいかな？" "$($TARGET_COMMAND --version|base64)" "dW5rby50b2lsZXQgdmVyc2lvbiDwn5KpLvCfkqku8J+SqSAoMjDwn5Kp8J+SqS/wn5Kp8J+SqS/w
n5Kp8J+SqSkK"

OK "全テスト終わり💩" ":"
