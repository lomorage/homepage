#!/bin/bash

usage="
$(basename $0) -p [osx|win|pi] [options...]

    -h show this help text
    -p platform, osx, win or pi
    -v lomoagent version string
    -u lomoagent zip download url
    -i lomoagent installation package download url
    -s lomoagent zip sha256 hash
    -V lomoUpg version string
    -U lomoUpg zip download url
    -I Raspberry pi image url
"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELEASE_JSON_PATH="$DIR/static/release.json"
INSTALLATION_EN_PATH="$DIR/content/installation.md"
INSTALLATION_ZH_PATH="$DIR/content/installation.zh.md"

PLATFORM=
AGENT_VERSION=
AGENT_ZIP_URL=
AGENT_PKG_URL=
AGENT_ZIP_HASH=
UPG_VERSION=
UPG_ZIP_URL=
PI_IMAGE_URL=

OPTIONS=hp:v:u:i:s:V:U:I:
PARSED=$(getopt $OPTIONS $*)
if [ $? -ne 0 ]; then
    echo "$usage"
    exit 2
fi

eval set -- "$PARSED"
while true; do
    case "$1" in
        -h)
            echo "$usage"
            exit
            ;;
        -p)
            PLATFORM=$2
            if [ "$PLATFORM" != "osx" ] && [ "$PLATFORM" != "win" ] && [ "$PLATFORM" != "pi" ]; then
                echo "platform should be either \"osx\" or \"win\" or \"pi\""
                exit
            else
                echo "replace for platform: $PLATFORM"
                shift 2
            fi
            ;;
        -v)
            AGENT_VERSION=$2
            echo "lomoagent version: $AGENT_VERSION"
            shift 2
            ;;
        -u)
            AGENT_ZIP_URL=$2
            echo "lomoagent zip url: $AGENT_ZIP_URL"
            shift 2
            ;;
        -i)
            AGENT_PKG_URL=$2
            echo "lomoagent installation package url: $AGENT_PKG_URL"
            shift 2
            ;;
        -s)
            AGENT_ZIP_HASH=$2
            echo "lomoagent zip sha256 hash: $AGENT_ZIP_HASH"
            shift 2
            ;;
        -V)
            UPG_VERSION=$2
            echo "lomoUpg version: $UPG_VERSION"
            shift 2
            ;;
        -U)
            UPG_ZIP_URL=$2
            echo "lomoUpg zip url: $UPG_ZIP_URL"
            shift 2
            ;;
        -I)
            PI_IMAGE_URL=$2
            echo "Raspberry Pi image url: $PI_IMAGE_URL"
            shift 2
            ;;
        --)
            if [ -z "${PLATFORM}" ]; then
                echo "platform required!"
                echo "$usage"
            fi
            shift
            break
            ;;
        *)
            echo "option not found!"
            echo "$usage"
            exit 3
            ;;
    esac
done

update_release() {
    echo -e "\n=====> update $RELEASE_JSON_PATH for $1..."
    changed=0
    if [ ! -z "$AGENT_VERSION" ]; then
        echo "update agent version: $AGENT_VERSION"
        cat $RELEASE_JSON_PATH | jq ".\"$1\".Version = \"$AGENT_VERSION\""  > tmp.$$.json && mv tmp.$$.json $RELEASE_JSON_PATH
        changed=1
    fi
    
    if [ ! -z "$AGENT_ZIP_URL" ]; then
        echo "update lomoagent zip url: $AGENT_ZIP_URL"
        cat $RELEASE_JSON_PATH | jq ".\"$1\".URL = \"$AGENT_ZIP_URL\""  > tmp.$$.json && mv tmp.$$.json $RELEASE_JSON_PATH
        changed=1
    fi
    
    if [ ! -z "$AGENT_ZIP_HASH" ]; then
        echo "update lomoagent hash: $AGENT_ZIP_HASH"
        cat $RELEASE_JSON_PATH | jq ".\"$1\".SHA256 = \"$AGENT_ZIP_HASH\""  > tmp.$$.json && mv tmp.$$.json $RELEASE_JSON_PATH
        changed=1
    fi

    if [ ! -z "$UPG_VERSION" ]; then
        echo "update lomoUpd version: $UPG_VERSION"
        cat $RELEASE_JSON_PATH | jq ".\"$1\".LomoUpgVer = \"$UPG_VERSION\""  > tmp.$$.json && mv tmp.$$.json $RELEASE_JSON_PATH
        changed=1
    fi
    
    if [ ! -z "$UPG_ZIP_URL" ]; then
        echo "update lomoUpd zip url: $UPG_ZIP_URL"
        cat $RELEASE_JSON_PATH | jq ".\"$1\".LomoUpdateURL = \"$UPG_ZIP_URL\""  > tmp.$$.json && mv tmp.$$.json $RELEASE_JSON_PATH
        changed=1
    fi

    if [ $changed == 1 ]; then
        cat $RELEASE_JSON_PATH
    else
        echo "no changes to $RELEASE_JSON_PATH"
    fi
    echo -e "=====> Done!"
}

update_page_win() {
    if [ ! -z "$AGENT_PKG_URL" ]; then
        echo -e "\n=====> update windows msi package on installation page"
        sed -i '' -E "s#https://github.com/lomorage/LomoAgentWin/releases/download/[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}\.[[:digit:]]{2}_[[:digit:]]{2}_[[:digit:]]{2}\.0\.[a-zA-Z0-9]{7}\/lomoagent\.msi#$AGENT_PKG_URL#g" $INSTALLATION_EN_PATH
        sed -i '' -E "s#https://github.com/lomorage/LomoAgentWin/releases/download/[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}\.[[:digit:]]{2}_[[:digit:]]{2}_[[:digit:]]{2}\.0\.[a-zA-Z0-9]{7}\/lomoagent\.msi#$AGENT_PKG_URL#g" $INSTALLATION_ZH_PATH
        grep -H "https://github.com/lomorage/LomoAgentWin/releases/download/" $INSTALLATION_EN_PATH
        grep -H "https://github.com/lomorage/LomoAgentWin/releases/download/" $INSTALLATION_ZH_PATH
        echo -e "=====> Done!"
    fi
}

update_page_osx() {
    if [ ! -z "$AGENT_PKG_URL" ]; then
        echo -e "\n=====> updated osx dmg package on installation page"
        sed -i '' -E "s#https://github.com/lomorage/LomoAgentOSX/releases/download/[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}\.[[:digit:]]{2}_[[:digit:]]{2}_[[:digit:]]{2}\.0\.[a-zA-Z0-9]{7}\/LomoAgent\.dmg#$AGENT_PKG_URL#g" $INSTALLATION_EN_PATH
        sed -i '' -E "s#https://github.com/lomorage/LomoAgentOSX/releases/download/[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}\.[[:digit:]]{2}_[[:digit:]]{2}_[[:digit:]]{2}\.0\.[a-zA-Z0-9]{7}\/LomoAgent\.dmg#$AGENT_PKG_URL#g" $INSTALLATION_ZH_PATH
        grep -H "https://github.com/lomorage/LomoAgentOSX/releases/download/" $INSTALLATION_EN_PATH
        grep -H "https://github.com/lomorage/LomoAgentOSX/releases/download/" $INSTALLATION_ZH_PATH
        echo -e "=====> Done!"
    fi
}

update_page_pi() {
    if [ ! -z "$PI_IMAGE_URL" ]; then
        echo -e "\n=====> updated Raspberry Pi image on installation page"
        sed -i '' -E "s#https://github.com/lomorage/pi-gen/releases/download/[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}\.[[:digit:]]{2}_[[:digit:]]{2}_[[:digit:]]{2}\.0\.[a-zA-Z0-9]{7}\/image_[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}-lomorage-lite\.zip#$PI_IMAGE_URL#g" $INSTALLATION_EN_PATH
        sed -i '' -E "s#https://github.com/lomorage/pi-gen/releases/download/[[:digit:]]{4}_[[:digit:]]{2}_[[:digit:]]{2}\.[[:digit:]]{2}_[[:digit:]]{2}_[[:digit:]]{2}\.0\.[a-zA-Z0-9]{7}\/image_[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}-lomorage-lite\.zip#$PI_IMAGE_URL#g" $INSTALLATION_ZH_PATH
        grep -H "https://github.com/lomorage/pi-gen/releases/download/" $INSTALLATION_EN_PATH
        grep -H "https://github.com/lomorage/pi-gen/releases/download/" $INSTALLATION_ZH_PATH
        echo -e "=====> Done!"
    fi
}

if [ "$PLATFORM" == "osx" ]; then
    update_release "darwin"
    update_page_osx
elif [ "$PLATFORM" == "win" ]; then
    update_release "windows"
    update_page_win
elif [ "$PLATFORM" == "pi" ]; then
    update_page_pi
else
    echo "platform $PLATFORM not support!"
fi


