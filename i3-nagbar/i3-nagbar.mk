ALL_TARGETS += i3-nagbar/i3-nagbar
INSTALL_TARGETS += install-i3-nagbar
CLEAN_TARGETS += clean-i3-nagbar

i3_nagbar_SOURCES := $(wildcard i3-nagbar/*.c)
i3_nagbar_HEADERS := $(wildcard i3-nagbar/*.h)

i3_nagbar_OBJECTS := $(i3_nagbar_SOURCES:.c=.o)


i3-nagbar/%.o: i3-nagbar/%.c $(i3_nagbar_HEADERS)
	echo "[i3-nagbar] CC $<"
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

i3-nagbar/i3-nagbar: libi3.a $(i3_nagbar_OBJECTS)
	echo "[i3-nagbar] Link i3-nagbar"
	$(CC) $(LDFLAGS) -o $@ $(filter-out libi3.a,$^) $(LIBS)

install-i3-nagbar: i3-nagbar/i3-nagbar
	echo "[i3-nagbar] Install"
	$(INSTALL) -d -m 0755 $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -m 0755 i3-nagbar/i3-nagbar $(DESTDIR)$(PREFIX)/bin/

clean-i3-nagbar:
	echo "[i3-nagbar] Clean"
	rm -f $(i3_nagbar_OBJECTS) i3-nagbar/i3-nagbar
