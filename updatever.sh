#!/bin/bash

usage="
$(basename $0) -p [osx|win|lomod] [options...]

    -h show this help text
    -p platform, osx, win or lomod
    -v lomoagent version string
    -u lomoagent zip download url
    -s lomoagent zip sha256 hash
    -V lomoUpg version string
    -U lomoUpg zip download url
    -C lomod commit hash in version
"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELEASE_JSON_PATH="$DIR/static/release.json"

PLATFORM=
AGENT_VERSION=
AGENT_ZIP_URL=
AGENT_ZIP_HASH=
UPG_VERSION=
UPG_ZIP_URL=

OPTIONS=hp:v:u:s:V:U:C:
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
            if [ "$PLATFORM" != "osx" ] && [ "$PLATFORM" != "win" ] && [ "$PLATFORM" != "lomod" ]; then
                echo "platform should be either \"osx\" or \"win\" or \"lomod\""
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
        -C)
            LOMOD_COMMIT=$2
            echo "Lomod Commit Hash: $LOMOD_COMMIT"
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

    if [ ! -z "$LOMOD_COMMIT" ]; then
        echo "update lomod commit: $LOMOD_COMMIT"
        cat $RELEASE_JSON_PATH | jq ".\"$1\".Commit = \"$LOMOD_COMMIT\""  > tmp.$$.json && mv tmp.$$.json $RELEASE_JSON_PATH
        changed=1
    fi

    if [ $changed == 1 ]; then
        cat $RELEASE_JSON_PATH
    else
        echo "no changes to $RELEASE_JSON_PATH"
    fi
    echo -e "=====> Done!"
}

if [ "$PLATFORM" == "osx" ]; then
    update_release "darwin"
elif [ "$PLATFORM" == "win" ]; then
    update_release "windows"
elif [ "$PLATFORM" == "lomod" ]; then
    update_release "lomod"
else
    echo "platform $PLATFORM not support!"
fi


