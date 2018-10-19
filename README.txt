#This is the list of commands to execute dockerfile.
#Currently it only has SalObj deployment but the purpose is to extend it according to our needs.

#First build the Dockerfile
docker build -t tssalojb .

#To run the docker container, you need to use the following command.
docker run -it --net=host --pid=host --name salObj tssalojb

#If the container has been created and is not running, run it first and then run a bash for use with the following commands.
docker run salObj 
docker exec -it salObj bash