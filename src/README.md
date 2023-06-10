docker network create microservices




docker build -t couponservice .

# Postgres 
docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres --network microservices -e POSTGRES_PASSWORD=postgres -d postgres

docker run --name local-couponapp -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d couponapp:latest

# mySQL
docker run --name mysqldb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=postgres -e MYSQL_PASSWORD=postgres -e MYSQL_DATABASE=postgres --network microservices -d mysql:5.7
docker run --name local-couponapp -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d coupon:latest

docker run --name local-couponapp -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgresdb:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

docker tag couponservice:latest 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest docker push 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

jdbc:postgresql://postgres.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres

docker run --name couponapp -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres -e SPRING_DATASOURCE_USERNAME=cloudinitservice -e SPRING_DATASOURCE_PASSWORD=$KJe4QIj%T21e2_k -e SPRING_PORT=8080 -d 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest


## Tagging and pushing images to ECR 
docker build -t 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:1.0 .
docker tag 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:1.0 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

3. Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 243302161856.dkr.ecr.us-east-1.amazonaws.com

docker push 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:1.0
docker push 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

docker run --name coupon-service -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:1.0


## Pushing an image to Docker Hub

1. docker login 

``` docker build -t whoajitpatil/couponservice:1.0 . ``` 

``` docker tag whoajitpatil/couponservice:1.0 whoajitpatil/couponservice:latest ```

``` docker push whoajitpatil/couponservice:1.0 ```

``` docker push whoajitpatil/couponservice:latest ```

Run app locally with Postgres and image local

```docker network create microservices```

``` docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres ```

``` docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres --network microservices -e POSTGRES_PASSWORD=postgres -d postgres ```

Run app locall with Postgres local and Image on DockerHub

``` docker run --name coupon-service -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgresdb:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d whoajitpatil/couponservice:latest ```

Run app locall with RDS On AWS and Image on DockerHub

``` docker run --name coupon-service -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d whoajitpatil/couponservice:latest ```

postgres-coupon.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432


jdbc:postgresql://postgres-coupon.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres