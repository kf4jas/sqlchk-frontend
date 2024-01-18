VERSION := 0.1.3

clean:
	-rm -rf dist
	-rm -rf env
build:
	npm run build

patch:
	git aftermerge patch || exit 1

minor:
	git aftermerge minor || exit 1

major:
	git aftermerge major || exit 1

