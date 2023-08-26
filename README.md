# About
Monet DB database for storing all the data which we use to make predictions. Think about raw price data, sentiment data, transformed data and also the predictions themselves.

# Deploy on server
1. In the root folder of the server, create a folder called "transformer"
2. Enter this folder and clone the monetdb repository
3. Create a file called "docker-compose.yml" in the transformer folder and paste the following code in it:
```yml
version: '3'
services:
  monetdb:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - monetdb_data:/var/lib/monetdb
    ports:
      - "50000:50000"
    env_file:
      - .env
    environment:
      - MONET_DBFARM=/var/lib/monetdb/dbfarm
      - MONET_DATABASE=transformer-btc
      - MONETDB_PASSWORD=${MONETDB_PASSWORD}
volumes:
  monetdb_data:
```
4. Create a file called ".env" in the transformer folder and paste the following code in it:
```env
MONETDB_PASSWORD=****
```
5. Bring the monetdb database online by running the following command: `docker-compose up --buid -d`
6. Check if the database is running by running the following command: `docker-compose ps`. You should see something like this:
```bash
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                           NAMES
825dcfabc25e   transformer-monetdb   "sh -c /init-monetdb…"   16 minutes ago   Up 16 minutes   0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   transformer-monetdb-1
```

