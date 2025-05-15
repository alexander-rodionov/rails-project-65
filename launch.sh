export SECRET_KEY_BASE=adfasjflkasjflkdsflkjsd
#echo Running db:migrate
#./bin/rails db:migrate
#echo Running db:seed
#./bin/rails db:seed
echo Launching server
./bin/rails s -b 0.0.0.0 -p 80
