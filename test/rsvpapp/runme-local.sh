set -ev
docker build -t rsvpapp:v1 .
docker network create rsvp_net
docker volume create db_data
docker run -d --name rsvp-db --network rsvp_net -v db_data:/data/db --expose 27017 -e MONGODB_DATABASE=rsvpdata mongo:3.3
docker run -d --name rsvp-web --network rsvp_net -p 5000:5000 -e MONGODB_HOST=rsvp-db -e LINK='http://www.meetup.com/cloudyuga/' -e TEXT1='CloudYuga' -e TEXT2='Garage RSVP!' -e LOGO='https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png' -e COMPANY='CloudYuga Technology Pvt. Ltd.' rsvpapp:v1 
