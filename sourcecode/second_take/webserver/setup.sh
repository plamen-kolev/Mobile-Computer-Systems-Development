
sudo -u postgres psql -c "CREATE USER rails_admin WITH PASSWORD 'somepassword';"
sudo -u postgres psql -c "CREATE DATABASE rails_neven OWNER rails_admin;"
sudo -u postgres psql -c "grant all privileges on database rails_neven to rails_admin;"
