.PHONY: build

build: static_analysis
	bundle exec rake

static_analysis:
	bundle exec rubocop --safe-auto-correct