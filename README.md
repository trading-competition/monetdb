# About
Monet DB database for storing all the data which we use to make predictions. Think about raw price data, sentiment data, transformed data and also the predictions themselves.

# Deploy on server
1. In the root folder of the server, create a folder called "transformer"
2. Create a file called "docker-compose.yml" in the transformer folder and paste the following code in it:
```yml
version: '3'
services:
  monetdb:
    image: erwinvink/monetdb:latest
    volumes:
      - monetdb_data:/var/lib/monetdb
    ports:
      - "50000:50000"
    env_file:
      - .env
volumes:
  monetdb_data:
```
3. Create a file called ".env" in the transformer folder and paste the lines from the .env_template file in it. Than fill in the password for the monetdb database:
4. Bring the monetdb database online by running the following command: `docker-compose up --buid -d`
5. Check if the database is running by running the following command: `docker-compose ps`. You should see something like this:
```bash
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                           NAMES
825dcfabc25e   transformer-monetdb   "sh -c /init-monetdb…"   16 minutes ago   Up 16 minutes   0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   transformer-monetdb-1
```

