# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/driftnet/driftnet-0.1.6-r5.ebuild,v 1.1 2014/08/22 14:30:54 creffett Exp $

EAPI=5
inherit eutils flag-o-matic

MY_P="${PN}_${PV}"
DESCRIPTION="A program which listens to network traffic and picks out images from TCP streams it observes"
HOMEPAGE="http://www.ex-parrot.com/~chris/driftnet/"
SRC_URI="mirror://debian/pool/main/d/driftnet/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/d/driftnet/${MY_P}-8.diff.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
SLOT="0"
IUSE="gtk"

RDEPEND="virtual/jpeg
	media-libs/giflib
	media-libs/libpng
	net-libs/libpcap
	gtk? ( x11-libs/gtk+:2 )"

DEPEND="${RDEPEND}
	>=x11-misc/makedepend-1.0.0
	virtual/pkgconfig"

S="${WORKDIR}/${P}.orig"

src_prepare() {
	epatch "${DISTDIR}"/${MY_P}-8.diff.gz

	# don't use gtk+ by default
	sed -i 's:^\(.*gtk-config.*\)$:#\1:g' Makefile || die "sed disable gtk failed"
}

src_configure() {
	if use gtk; then
		sed -i 's:^#\(.*gtk-config.*\)$:\1:g' Makefile || die "sed enable gtk failed"
	else
		append-flags -DNO_DISPLAY_WINDOW
	fi
}

src_compile() {
	if use gtk; then
		emake || die "gtk+ build failed"
		mv driftnet driftnet-gtk
		make clean || die
	fi

	emake
}

src_install () {
	dobin driftnet
	doman driftnet.1

	use gtk && dobin driftnet-gtk

	dodoc CHANGES CREDITS README TODO

	elog "marking the no-display driftnet as setuid root."
	chown root:wheel "${D}/usr/bin/driftnet"
	chmod 750 "${D}/usr/bin/driftnet"
	chmod u+s "${D}/usr/bin/driftnet"
}
