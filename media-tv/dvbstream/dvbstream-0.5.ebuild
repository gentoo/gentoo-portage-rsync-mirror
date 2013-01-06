# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/dvbstream/dvbstream-0.5.ebuild,v 1.6 2012/02/15 18:32:24 hd_brummy Exp $

inherit eutils

IUSE=""

DESCRIPTION="simple command line tools for DVB cards. Includes a RTP multicast stream server"
HOMEPAGE="http://sourceforge.net/projects/dvbtools"
SRC_URI="mirror://sourceforge/dvbtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-lang/perl"
DEPEND="virtual/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A}

	#epatch ${FILESDIR}/${P}-gentoo.diff
	cd "${S}"
	sed -i Makefile \
		-e 's:$(CFLAGS):$(CFLAGS) $(CPPFLAGS):' \
		-e '/CFLAGS.*=.*-g -Wall -O2/s:-g -Wall -O2::' \
		-e '/CFLAGS.*=/s:CFLAGS:CPPFLAGS:' \
		-e 's:-I \.\./DVB/include:-I /usr/include:'

	cp TELNET/svdrpsend.pl dvbstream-send.pl
	cp TELNET/README README.telnet

	sed -e 's:\./svdrpsend.pl:dvbstream-send.pl:' \
		-i TELNET/*.sh

	sed -e 's:^DUMPRTP=.*$:DUMPRTP=dumprtp:' \
		-e 's:^TS2ES=.*$:TS2ES=ts2es:' \
		-i *.sh
}

src_install() {
	dobin dvbstream dumprtp rtpfeed ts_filter dvbstream-send.pl

	dodoc README*

	insinto /usr/share/doc/${PF}/tune
	doins TELNET/*.sh

	insinto /usr/share/doc/${PF}/multicast
	doins *.sh
}
