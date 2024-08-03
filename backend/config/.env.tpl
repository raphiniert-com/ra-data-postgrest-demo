# Docker specific configs
# use only letters and numbers for the project name
COMPOSE_PROJECT_NAME=demo-db


# Global configs
DEVELOPMENT=1
JWT_SECRET=reallyreallyreallyreallyverysafe

# DB connection details (used by all containers)
# set PG_VERSION to match your production db major version
PG_VERSION=latest
DB_HOST=db
DB_PORT=5432
DB_NAME=app
DB_SCHEMA=api
DB_USER=authenticator
DB_PASS=authenticatorpass

# OpenResty
POSTGREST_HOST=postgrest
POSTGREST_PORT=3000

# PostgREST
DB_ANON_ROLE=anonymous
DB_POOL=10
#MAX_ROWS=
#PRE_REQUEST=
SERVER_PROXY_URI=http://localhost:8080/rest
ROLE_CLAIM_KEY=.resource_access.frontend.roles[0]
OPENAPI_SERVER_PROXY_URI=http://localhost:8080/rest/

# KeyCloak
KEYCLOAK_ADMIN=admin
KEYCLOAK_PASSWORD=admin
KEYCLOAK_PORT=8080
KEYCLOAK_HOST=keycloak

# KeyCloak database
KEYCLOAK_POSTGRES_USER=superuser
KEYCLOAK_POSTGRES_PASSWORD=superuserpass

# PostgreSQL container config
# Use this to connect directly to the db running in the container
SUPER_USER=superuser
SUPER_USER_PASSWORD=superuserpass

# zombo search setting var
ZOMBO_SEARCH_MIN_TOKEN=2
ZOMBO_MAX_RESULTS=100


# i2b2 settings
# i2b2 FDW
FDW_USER=i2b2
FDW_PASSWORD=demouser
FDW_PORT=5432
FDW_HOST=i2b2-pg
FDW_DB=i2b2
FDW_DATA_SCHEMA=i2b2demodata

# Versions of the i2b2 images
I2B2_VERSION_PG=0.1
I2B2_PG_SUPER_USER_PASSWORD=superuserpass
