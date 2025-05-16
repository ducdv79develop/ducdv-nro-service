echo "stop ducdv-nro-game-server"
docker stop ducdv-nro-game-server
echo "stop server success!!!!"

echo "cd ducdv-nro-java-server"
# shellcheck disable=SC2164
cd ducdv-nro-java-server

echo "git fetch"
git fetch

echo "git pull origin production"
git pull origin production

echo "cd .."
# shellcheck disable=SC2103
cd ..

echo "start ducdv-nro-game-server"
docker start ducdv-nro-game-server
echo "start server success!!!!"
