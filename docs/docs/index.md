# ts_Dockerfiles
Docker is a containerization application.
This repo is where TSSW Docker related software is contained.

## Organization
```
.
├── aos_aoclc
│   ├── Dockerfile
│   └── README.md
├── aos_env
│   ├── Dockerfile
│   └── README.md
├── aos_sal
│   ├── Dockerfile
│   └── README.md
├── ataos
│   ├── Dockerfile
│   └── setup.sh
├── at_dome_sim
│   ├── Dockerfile
│   └── setup.sh
├── at_dome_trajectory_sim
│   ├── Dockerfile
│   └── setup.sh
├── at_hexapod
│   ├── Dockerfile
│   └── setup.sh
├── at_mcs_sim
│   ├── Dockerfile
│   └── setup.sh
├── at_pneumatics_sim
│   ├── Dockerfile
│   └── setup.sh
├── atspectrograph
│   ├── Dockerfile
│   └── setup.sh
├── Compose
│   ├── atptg_atmcs_integration
│   │   └── docker-compose.yml
│   ├── lab_jupyter_servers
│   │   ├── atdiag03_notebook_config.py
│   │   ├── atdiag03_setup.sh
│   │   ├── atdiag04_notebook_config.py
│   │   ├── atdiag04_setup.sh
│   │   ├── atdiag05_notebook_config.py
│   │   ├── atdiag05_setup.sh
│   │   └── docker-compose.yml
│   └── Simulators
│       ├── docker-compose.yaml
│       ├── docker_log.log
│       ├── README.md
│       └── startJupyter.sh
├── develop-env
│   ├── develop_py36
│   │   ├── Dockerfile
│   │   ├── lsst-ts.repo
│   │   └── setup.sh
│   ├── develop_py37
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── latest
│   │   ├── Dockerfile
│   │   └── setup.sh
│   └── light
│       ├── Dockerfile
│       └── lsst-ts.repo
├── dm-test
│   ├── Devel
│   │   ├── Dockerfile
│   │   ├── environment.env
│   │   ├── README.txt
│   │   ├── requirements.txt
│   │   ├── salgenerate.sh
│   │   └── startup.sh
│   ├── EFD
│   │   ├── create-tables.sh
│   │   ├── Dockerfile
│   │   ├── environment.env
│   │   ├── requirements.txt
│   │   └── salgenerate.sh
│   └── MariaDB
│       ├── Dockerfile
│       └── README
├── docs
│   ├── docs
│   │   └── index.md
│   └── mkdocs.yml
├── efd
│   ├── Dockerfile
│   ├── kafka
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── my.cfg
│   └── writers
│       ├── Dockerfile
│       └── setup.sh
├── efd_mariadb
│   ├── Dockerfile
│   └── README
├── efd_writers
│   └── Dockerfile
├── electrometer
│   ├── Dockerfile
│   ├── Electrometer
│   │   ├── docker-compose.yaml
│   │   ├── mainSetup.yaml
│   │   ├── startCSC.sh
│   │   └── startGUI.sh
│   ├── Electrometer.zip
│   └── setup.sh
├── environment
│   ├── Dockerfile
│   └── setup.sh
├── labview
│   ├── cintools.tar
│   └── Dockerfile
├── monochromator
│   ├── Dockerfile
│   └── setup.sh
├── mtaos_dev
│   ├── Dockerfile
│   └── README.md
├── mtaos_sim
│   ├── Dockerfile
│   └── README.md
├── mtcamerahexapod_sim
│   ├── Dockerfile
│   ├── mtcamerahexapod_csc.py
│   └── README.md
├── mtm1m3_sim
│   ├── Dockerfile
│   └── README.md
├── mtm2hexapod_sim
│   ├── Dockerfile
│   ├── mtm2hexapod_csc.py
│   └── README.md
├── mtm2_sim
│   ├── Dockerfile
│   ├── mtm2_csc.py
│   └── README.md
├── no_lsst_stack
│   ├── Dockerfile
│   ├── environment.env
│   ├── README.txt
│   ├── requirements.txt
│   ├── salgenerate.sh
│   └── startup.sh
├── pointing_component
│   ├── Dockerfile
│   ├── Dockerfile_withstack
│   ├── gui
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── known_hosts
│   ├── README
│   ├── sal3.9_dev
│   │   ├── Dockerfile
│   │   ├── known_hosts
│   │   └── setup.sh
│   ├── sal3.9_rpm
│   │   ├── Dockerfile
│   │   ├── known_hosts
│   │   ├── lsst-ts.repo
│   │   └── setup.sh
│   └── setup.sh
├── pointing_qa
│   └── Dockerfile
├── ptg
│   ├── Dockerfile
│   ├── README
│   ├── requirements.txt
│   └── run.sh
├── queue-env
│   ├── Dockerfile
│   ├── setup_and_build.sh
│   └── setup.sh
├── queue-env-py37
│   ├── Dockerfile
│   ├── setup_and_build.sh
│   └── setup.sh
├── queue-rpm
│   ├── Dockerfile
│   ├── lsst-ts.repo
│   └── setup.sh
├── README.md
├── robot
│   ├── bash_profile
│   ├── Dockerfile
│   ├── README
│   └── Test_Vars.txt
├── robotsal
│   ├── Dockerfile
│   ├── README
│   └── start.sh
├── simulation_tests
│   ├── atptgatmcsintegration.py
│   ├── Dockerfile
│   └── dometrajectorymcs.py
├── tunable_laser
│   ├── Dockerfile
│   ├── load_laser.sh
│   └── README.md
└── with_lsst_stack
    ├── Dockerfile
    ├── environment.env
    ├── requirements.txt
    ├── salgenerate.sh
    └── startup.sh
```
Our directory structure is as follows.
Folders denote the particular docker container typically a CSC but also include auxiliary containers such as for the EFD and the like.
Inside the folders are the docker files, this allows for easier development practice of making changes to interelated containers.
The Compose directory contains the compose files neccessary for bringing up multiple containers.
The Simulators directory contains the auxtel simulators.
The tagging of docker container for python CSCs is still up for debate.
Here's a list of potential options.

1. cscversion\_salversion\_salobjversion
