# arachni_rest
Docker build for Arachni scanner with REST API

## Arachni
Arachni is a feature-full, modular, high-performance Ruby framework aimed towards helping penetration testers and administrators evaluate the security of modern web applications. see the good work here: www.arachni-scanner.com

## Why
The REST API is used extensively when intergrating with CI/CD tools such as Jenkins. For many organisations using this API is a requirement.

Furthermore, the default sqlite deployment has many limitations as described on the arachni webui landing page. This image has been preconfigured to used postgres as the database to overcome these limitations.

## Official Docs
https://github.com/Arachni/arachni/wiki/REST-API

## versions
`swtr/arachni_rest:latest` - arachni framework v1.5.1 & webui v0.5.12

## How

### Using Compoose
The quickest and easiest way to use this image is to use docker-compose straight from the source directory. This will deploy both Arachni REST API and Postgres

`sudo docker-compose up`

### Alternatively
You can deploy things individually using the official postgres Docker image

Pull Postgres

`docker pull postgres`

Configure postgres for arachni

`docker run --name postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=arachni -e POSTGRES_DB=arachni_production -d postgres`

Pull Arachni

`docker pull swtr/arachni_rest`

Run Arachni and connect it to postgres

`docker run -t --name arachni --link postgres -p 7331:7331 swtr/arachni_rest`

## Config info
### Arachni REST Server
The credentials for accessing the REST API are defined as environment variables. The variables for credential storage are:

`ARACHNI_REST_USER arachni`
`ENV ARACHNI_REST_PASS secret`

The password should change automatically on initial boot, however they're there if you want to control them yourself too. 

### Postgres
The database configuration settings for Arachni are configured by environment variables. By default they have been preconfigured with what comes out of the box from the Arachni developers. The variables of interest for this image are (with their default values):

`POSTGRES_HOST postgres`
`POSTGRES_DATABASE arachni_production`
`POSTGRES_USERNAME arachni`
`POSTGRES_PASSWORD secret`

Manipulate as required by starting the image using `-e`. For example if you have an external Postgres server:

`docker run --name arachni -e POSTGRES_HOST=server.com -p 7331:7331 swtr/arachni_rest`

# Licence
All configuration files and scripts are licensed under the MIT license.

# About Shearwater
Shearwater is a specialist information security services provider. We address four of the key information security challenges confronting organisations today, the challenges of securing applications; managing security operations; maintaining compliance, and improving awareness and security education across the board. We provide a combination of integrated services and capabilities delivered through our highly experienced information security and risk professionals.

https://www.shearwater.com.au/