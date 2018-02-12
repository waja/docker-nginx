IMAGE_NAME := waja/nginx

build:
	docker build --rm -t $(IMAGE_NAME) .
	
run:
	@echo docker run --rm -it $(IMAGE_NAME) 
	
shell:
	docker run --rm -it --entrypoint sh $(IMAGE_NAME) -l

test: build
	@if ! [ "$$(docker run --rm -it $(IMAGE_NAME) nginx -v | head -1 | cut -d' ' -f1)" = "nginx" ]; then exit 1; fi
