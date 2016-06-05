BUILD = node_modules/.bin/skewc src compiled

default: build-release

npm-modules:
	npm install

build-shaders: | npm-modules
	mkdir -p compiled
	node_modules/.bin/glslx src/sunflower/sunflower.glslx --output=compiled/sunflower-shaders.sk --format=skew --pretty-print

build: | npm-modules build-shaders
	$(BUILD) --output-file=www/compiled.js

build-release: | npm-modules build-shaders
	$(BUILD) --release --output-file=www/compiled.js

watch: | npm-modules
	node_modules/.bin/watch src 'clear && make build'

clean:
	rm www/compiled.js
	rm -rf www/glsl