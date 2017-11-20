# ![Logo](moyashi.png)ｍｏｙａｓｈｉ

Imageboards done right.


## Running

> You must have `docker` and `docker-compose` installed

### Dev environment

1. You must set the following enviroment variables

    Variable | Description | Example
    -- | --- | --- 
    `PHX_DEVDB_PASSWORD` | Development enviroment postgresql password | `foobar`
    `PHX_TESTDB_PASSWORD` | Postgresql password for running tests | `foobar` 
    `POSTGRES_PASSWORD` | Postregresql container password | `foobar`

    > You can use `.env`

2. Build images with `docker-compose`

    ```
    docker-compose build
    ```

3. If that's the first run, we have to run some ecto tasks
    
    Create the database

    ```
    docker-compose run web mix ecto.create
    ```

    Run migrations

    ```
    docker-compose run web mix ecto.migrate
    ```

4. Now we can set everything up
    
    ```
    docker-compose up
    ```