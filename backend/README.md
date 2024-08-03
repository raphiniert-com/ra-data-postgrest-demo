# demo-db
This project shows a demo backend, for FoRMeD with the following features:
- Full text search
- FHIR storage using [fhirbase](https://www.health-samurai.io/fhirbase)
- i2b2 attached via foreign data wrapper
- authentication via KeyCloak

For further information about the underlying postgREST starterkit read [README_starterkit.md](README_starterkit.md).

## Setup

### Elastic Search
In order to setup ES please make sure `vm.max_map_count` is setup properly. 
You can simply run 
```
sudo sysctl -w vm.max_map_count=262144
```

Read [here](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/vm-max-map-count.html) for more information.

### Start it
In order to start the backend just execure `start.sh`.

### KeyCloak

For authentication KeyCloak is used. This powerful tool enables you to integrate OAuth, LDAP or ActiveDirectory. Per default no user is setup. For demo purpose, we recommend to setup a demo user, as explained below. 

#### Create Example User
Go to `http://localhost:8080/auth` and login with user `admin` and password `admin` (might be different, in case you changed this in `.env`). In the UI go  to `Users` and klick `add user`.
Enter a username, e.g. `user` and klick `Save`. Next, setup a password by going to the tab `Credentials` which is visible now. Change `Temporary` to `Off` and enter a password, e.g. `test`.
Finally, roles must be setup in the tab `Role Mappings`. Select `frontend` in the Dropdown `Client Roles`. Now assign the role `webuser` in `Available Roles`. Done!

Use the following commands to test the login:

```bash
# login
USER="user"
PASSWORD="test"

JWT=$(curl -s --location --request POST 'http://localhost:8080/auth/realms/formed-api/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username=$USER' \
--data-urlencode 'password=$PASSWORD' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id=frontend' | jq -r .access_token)
```
