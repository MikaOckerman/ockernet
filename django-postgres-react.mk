# PostgreSQL and Django Setup in GitHub Codespaces

## PostgreSQL Setup

### Install PostgreSQL

sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

### Start PostgreSQL Service

sudo service postgresql start

### Add PostgreSQL Bin to PATH

export PATH="/usr/lib/postgresql/*/bin:$PATH"

### Create PostgreSQL User `Joy_WeShare`

sudo -u postgres psql -c "CREATE USER \"Joy_WeShare\" WITH PASSWORD '1234';"

### Create Database `thejoy_db`

sudo -u postgres psql -c "CREATE DATABASE thejoy_db;"

### Grant Privileges to `Joy_WeShare` on `thejoy_db`

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE thejoy_db TO \"Joy_WeShare\";"

### Configure `pg_hba.conf` for md5 Authentication

- Edit `pg_hba.conf`:
  sudo nano /etc/postgresql/13/main/pg_hba.conf
- Add or modify for local connections:
  local   all             Joy_WeShare                            md5
- Save and exit.

### Reload PostgreSQL to Apply Changes

sudo service postgresql reload

## Django Configuration

### Install Django and Psycopg2

pip install django psycopg2-binary

### Update `settings.py` for Database Configuration

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'thejoy_db',
        'USER': 'Joy_WeShare',
        'PASSWORD': '1234',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}

### Run Django Migrations

python manage.py migrate

## Notes

- **Security**: Use environment variables for `PASSWORD` in `settings.py` in production.
- **Persistence**: Remember, in Codespaces, you'll need to run these steps or a script that includes them each time you start a new session or rebuild your environment if not automated in a `devcontainer.json`.
- **Environment**: The `PATH` update for PostgreSQL might need to be in your `.bashrc` or equivalent for persistence across sessions in Codespaces.
