DESTDIR=${HOME}

docs:
	podselect run > README.pod
	podselect -section LICENSE run > LICENSE.pod

install:
	mkdir -p $(DESTDIR)/bin
	install run $(DESTDIR)/bin
	install run-util $(DESTDIR)/bin
