ROOT=/absolute/path/to/aida/tools/aida-evaluation

RUNTYPE=practice

RUNS=$(ROOT)/M36-practice/runs
SCORES=$(ROOT)/M36-practice/scores
RUNID=example-run
HOST_INPUT_DIR=$(RUNS)/$(RUNID)
HOST_OUTPUT_DIR=$(SCORES)/$(RUNID)
HOST_DATA_DIR=$(ROOT)/docker/AUX-data/M36-$(RUNTYPE)/
GRAPHDB_VERSION=9.3.3
GRAPHDB_EDITION=free

ENG_TEXT_IOU_THRESHOLD=0.1
SPA_TEXT_IOU_THRESHOLD=0.1
RUS_TEXT_IOU_THRESHOLD=0.1
IMAGE_IOU_THRESHOLD=0.1
VIDEO_IOU_THRESHOLD=0.1

all:
	@echo "Usage: make [build|run]"	

build:
	docker build \
	       --build-arg version=$(GRAPHDB_VERSION) \
	       --build-arg edition=$(GRAPHDB_EDITION) \
	       -t aida-evaluation .

evaluate:
	make run RUNTYPE=evaluation

run:
	docker run \
                --env RUNID=$(RUNID) \
                --env RUNTYPE=$(RUNTYPE) \
                --env ENG_TEXT_IOU_THRESHOLD=$(ENG_TEXT_IOU_THRESHOLD) \
                --env SPA_TEXT_IOU_THRESHOLD=$(SPA_TEXT_IOU_THRESHOLD) \
                --env RUS_TEXT_IOU_THRESHOLD=$(RUS_TEXT_IOU_THRESHOLD) \
                --env IMAGE_IOU_THRESHOLD=$(IMAGE_IOU_THRESHOLD) \
                --env VIDEO_IOU_THRESHOLD=$(VIDEO_IOU_THRESHOLD) \
		-v $(HOST_INPUT_DIR):/evaluate:ro \
		-v $(HOST_OUTPUT_DIR):/score \
		-v $(HOST_DATA_DIR):/data \
	-it aida-evaluation
