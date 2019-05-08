# TS Simulators
A docker compose file (in yaml format) that invokes the T&S simulators required to run integration scripts.

## Usage

Clone the ts_Dockefiles repository:
```sh
 $ git clone -b feature/couger01/dm-18753 https://github.com/lsst-ts/ts_Dockerfiles.git
```

Navigate to the Compose/Simulators directory:
```sh
 $ cd Compose/Simulators
```

Invoke the simulators in dettached mode file: 
```sh
 $ docker-compose up -d
```

Check Containers:
```sh
 // Check Names, Image Id & Size
 $ docker-compose images
 
 // Check ID
 $ docker ps
 
 // Check Status
 $ docker-compose ps
 
 // Check Specific Logs
 $ docker-compose logs -f <container-name>
 
 // Check All Logs
 $ docker-compose logs
 
 // Grab the IP address of a running container
 $ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-name OR id>
 
 // View the details of docker network
 $ docker network inspect <my-bridge-network>
 
 // View container usage of cpu, memory, etc.
 $ docker stats $(docker ps --format={{.Names}})
```

Manipulate Containers:
```sh
 // Execute a command inside the running container (interactive mode)
 $ docker exec -it <container-id> <command>
  
 // Execute a command inside the running container (detached mode)
 $ docker exec -d <container-id> <command>
  
 // Stop Specific Container
 $ docker-compose stop <container-name>
 
 // Remove Specific Container
 $ docker-compose rm <container-name>
 
 // Start Specific Containers
 $ docker-compose start <container-name>
 
 // Stop & Remove Specific Container
 $ docker-compose down 

 // Stop All Containers
 $ docker-compose stop
 
 // Remove All Container
 $ docker-compose rm <container-name>
 
 // Start All Containers
 $ docker-compose start <container-name>
 
 // Stop & Remove All Container
 $ docker-compose down 
 ```

---

# License
 
LSST Data Management System Software
Copyright © 2008-2019 AURA/LSST.

This product includes software developed by the
LSST Project (http://www.lsst.org/) with contributions made at LSST partner
institutions.  The list of partner institutions is found at:
http://www.lsst.org/lsst/about/contributors .

Use and redistribution of this software is covered by the GNU Public License 
Version 3 (GPLv3) or later, as detailed below.  A copy of the GPLv3 is also 
available at  [GNU Licenses](http://www.gnu.org/licenses/).


