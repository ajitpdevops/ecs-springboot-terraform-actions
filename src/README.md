docker network create microservices

docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres --network microservices -e POSTGRES_PASSWORD=postgres -d postgres

docker build -t couponservice .

docker run --name local-couponapp -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgresdb:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

docker tag couponservice:latest 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest docker push 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest

jdbc:postgresql://postgres.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres

docker run --name couponapp -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres.ckcrtwddlse1.us-east-1.rds.amazonaws.com:5432/postgres -e SPRING_DATASOURCE_USERNAME=cloudinitservice -e SPRING_DATASOURCE_PASSWORD=$KJe4QIj%T21e2_k -e SPRING_PORT=8080 -d 243302161856.dkr.ecr.us-east-1.amazonaws.com/coupon:latest


## Pushing an image to Docker Hub

1. docker login 

``` docker build -t whoajitpatil/couponservice:1.0 . ``` 

``` docker tag whoajitpatil/couponservice:1.0 whoajitpatil/couponservice:latest ```

``` docker push whoajitpatil/couponservice:1.0 ```

``` docker push whoajitpatil/couponservice:latest ```

``` docker run --name postgresdb -p 5432:5432 -e POSTGRES_USER=postgres --network microservices -e POSTGRES_PASSWORD=postgres -d postgres ```

``` docker run --name coupon-service -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgresdb:5432/postgres -e SPRING_DATASOURCE_USERNAME=postgres -e SPRING_DATASOURCE_PASSWORD=postgres -e SPRING_PORT=8080 --network microservices -d whoajitpatil/couponservice:latest ```
