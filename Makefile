VERSION := 0.1.2

clean:
	-rm -rf dist
	-rm -rf env

patch:
	git aftermerge patch || exit 1

minor:
	git aftermerge minor || exit 1

major:
	git aftermerge major || exit 1

