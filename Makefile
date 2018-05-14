DESTDIR=${HOME}

docs:
	./run -m > README.md

install:
	mkdir -p $(DESTDIR)/bin
	install run $(DESTDIR)/bin
