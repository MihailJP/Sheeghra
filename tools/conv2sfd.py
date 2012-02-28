#!/usr/local/bin/fontforge

import sys
import re
import fontforge

if (len(sys.argv) != 4):
	print 'Usage: %s source-ttf vtp-file target-sfd' % sys.argv[0]
	exit(1)

font = fontforge.open(sys.argv[1], 1)
font.encoding = "original"

vtp = open(sys.argv[2])
reGlyph = re.compile("^DEF_GLYPH \"(\\w+)\" ID (\\d+)")
for line in vtp.readlines():
	m = reGlyph.match(line)
	if m: font[int(m.group(2))].glyphname = m.group(1)

font.save(sys.argv[3])
