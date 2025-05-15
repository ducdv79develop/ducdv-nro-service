docker stop ducdv-nro-game-server

# shellcheck disable=SC2164
cd ducdv-nro-java-server
git fetch
git pull origin production
# shellcheck disable=SC2103
cd ..

docker start ducdv-nro-game-server
