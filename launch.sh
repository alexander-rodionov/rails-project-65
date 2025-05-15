export SECRET_KEY_BASE=adfasjflkasjflkdsflkjsd
./bin/rails db:migrate
./bin/rails db:seed
./bin/rails s -b 0.0.0.0 -p 80
