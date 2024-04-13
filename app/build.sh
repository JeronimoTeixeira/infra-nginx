echo "Iniciando..."
docker build -t nginx-ms .
docker tag nginx-ms:latest 000000000000.dkr.ecr.us-east-1.localhost.localstack.cloud:4510/nginx-ms:latest
docker push 000000000000.dkr.ecr.us-east-1.localhost.localstack.cloud:4510/nginx-ms:latest
echo "Finalizando.."