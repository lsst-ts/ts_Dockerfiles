# Targets for building and pushing docker containers

IMAGE_TAG := w_2020_16_sal

.PHONY: build push mtaos_sim aos_sal push_mtaos_sim latest_mtaos_sim aos_aoclc no_lsst_stack with_lsst_stack

build: mtaos_sim

aos_sal:
	cd $@ && docker build -t lsstts/$@:$(IMAGE_TAG) .

aos_aoclc: aos_sal
	cd $@ && docker build -t lsstts/$@:$(IMAGE_TAG) --build-arg IMAGE_TAG=$(IMAGE_TAG) .

mtaos_sim: aos_sal aos_aoclc
	cd $@ && docker build -t lsstts/$@:$(IMAGE_TAG) --build-arg IMAGE_TAG=$(IMAGE_TAG) .

push_mtaos_sim: latest_mtaos_sim
	@echo "Push *:$(IMAGE_TAG)"
	for dir in mtaos_sim aos_sal aos_aoclc; do \
		docker push lsstts/$${dir}:$(IMAGE_TAG); \
	done
	@echo "Push *:latest"
	for dir in mtaos_sim aos_sal aos_aoclc; do \
		docker push lsstts/$${dir}:latest; \
	done

latest_mtaos_sim: mtaos_sim aos_sal aos_aoclc
	$(foreach dir, $^, $(shell docker tag lsstts/${dir}:$(IMAGE_TAG) lsstts/${dir}:latest))

no_lsst_stack:
	cd $@ && docker build -t salobj .

with_lsst_stack:
	cd $@ && docker build -t salobj .
