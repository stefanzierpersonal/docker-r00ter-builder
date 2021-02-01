# Docker r00ter Builder

A dockerized build environment to build [r00ter](https://www.ofmodemsandmen.com/). 

## Usage

1. Have docker installed ([instructions](https://docs.docker.com/engine/install/))
2. Download this repository:
   
   ```bash
   git clone git@github.com:stefanzierpersonal/docker-r00ter-builder.git
   ```
   
3. Get the `RooterNNNNNN.zip` file from the [r00ter site](http://www.ofmodemsandmen.com/builds/) or request the latest from [dairyman](https://forums.whirlpool.net.au/user/483126). 
4. Place `RooterNNNNNN.zip` in the `docker-r00ter-builder` directory.
5. Edit `Dockerfile` and change `ROOTER_VER` to the `NNNNNNN` from your `.zip` file.
6. Run `./create-docker-image.sh` to create the docker image.

Congratulations, you now have a docker image on your machine with all the prerequisites to build r00ter!

## Running a build

1. Run the following commands.

   ```bash
   cd docker-r00ter-builder
   ./run-docker-image.sh
   ```
2. This gives you a shell in the build environment. Follow r00ter instructions to build the image for your target.
3. When you are done, `exit` from the docker container. 
4. The build output (i.e. the image for your router) will be deposited in `~/rooter-builds` on your docker host. 
