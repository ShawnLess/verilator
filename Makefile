dockerfile = $(abspath .)/Dockerfile
docker_image_name = verilator
docker_cmd = docker run -v $(abspath .):/home -it $(docker_image_name)

default: build_docker

build_docker:
	docker build -f $(dockerfile) -t $(docker_image_name) .

run_docker:
	$(docker_cmd)
	
prune_docker:
	docker image prune -a
