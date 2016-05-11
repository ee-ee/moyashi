all: css images js

images: web/static/assets/images/*
	mkdir -p priv/static/images
	cp -r web/static/assets/images/* priv/static/images/

css: web/static/css/*
	mkdir -p priv/static/css
	sassc -t compressed --sourcemap web/static/css/app.scss priv/static/css/app.css

js: web/static/js/*
	mkdir -p priv/static/js
	cat web/static/js/* > priv/static/js/app.js
