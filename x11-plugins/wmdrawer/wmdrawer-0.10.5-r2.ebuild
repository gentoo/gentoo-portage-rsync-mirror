# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdrawer/wmdrawer-0.10.5-r2.ebuild,v 1.10 2012/05/05 05:12:01 jdhore Exp $

EAPI="1"

inherit eutils

IUSE=""
DESCRIPTION="dockapp which provides a drawer (retractable button bar) to launch applications"
SRC_URI="http://people.easter-eggs.org/~valos/wmdrawer/${P}.tar.gz"
HOMEPAGE="http://people.easter-eggs.org/~valos/wmdrawer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk+-2.patch

	# Honour Gentoo CFLAGS
	sed -i -e "s|-O3|${CFLAGS}|" Makefile || die

	# Fix LDFLAGS ordering per bug #248640
	sed -i 's/$(CC) $(LDFLAGS) -o $@ $(OBJS)/$(CC) -o $@ $(OBJS) $(LDFLAGS)/' Makefile || die

	# Do not auto-strip binaries
	sed -i 's/	strip $@//' Makefile || die

	# Honour Gentoo LDFLAGS
	sed -i 's/$(CC) -o/$(CC) $(REAL_LDFLAGS) -o/' Makefile || die
}

src_compile() {
	emake REAL_LDFLAGS="${LDFLAGS}" || die "make failed"
}

src_install() {
	dobin wmdrawer
	dodoc README TODO AUTHORS ChangeLog wmdrawerrc.example
	doman doc/wmdrawer.1x.gz
}
