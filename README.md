# Node Publish Local

A simple way to locally publish NPM packages to promote code modularity using verdaccio and Docker.

You need to have Docker up and running on your machine to use npl.

## Install
`sudo cp npl.sh /usr/bin/npl`

## Usage
Use `npl publish` instead of `npm publish`

On local publish it will ask you to create a new user. Put anyhting you want.

Stop the local registry from having priority over NPM (and restore previous registry if any)
`npl stop`

Reset local registry
`npl clean`

If dependencies are not found 
