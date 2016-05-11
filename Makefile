all: css

css: web/static/css/*
	sassc -t compressed --sourcemap web/static/css/app.scss priv/static/css/app.css
