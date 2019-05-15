#!/bin/sh

# https://github.com/DKFN/npl

localRegistry="http://localhost:4873/"
previousReg=$(npm config get registry)

publish() {
    if [ ! "$(docker ps -a | grep verdaccio-npl)" ];
    then
        echo "Node Publish Local"
        echo "Launching local registry ..."
        docker run -d --name verdaccio-npl -p 4873:4873 verdaccio/verdaccio
        sleep 2;
        npm adduser --registry  "$localRegistry"
    fi
    previousReg=$(npm config get registry)

    if [ ! "$previousReg" = "$localRegistry" ];
    then
        echo "Saving previous registry as : $previousReg"
        echo "$previousReg" > ~/.npl-previousReg
    fi

    npm set registry ${localRegistry}
    wd=$(pwd)
    npm publish "$wd"
    echo "Go ahead and npm install your project with your local published dependency/version. All orther dependencies will be fetched on npm official registry"
}

clean() {
    docker rm -f verdaccio-npl
    docker run -d --name verdaccio-npl -p 4873:4873 verdaccio/verdaccio
    sleep 2;
    npm adduser --registry  "$localRegistry"
}

stop() {
    oldReg=$(cat ~/.npl-previousReg)
    echo "Reseting registry as ${oldReg}"
    npm set registry "$oldReg"
    docker rm -f verdaccio-npl
}

# Command execution
$1

if [ -z "$1" ]; then
    echo "NodePublishLocal - http://github.com/DKFN/npl";
fi
