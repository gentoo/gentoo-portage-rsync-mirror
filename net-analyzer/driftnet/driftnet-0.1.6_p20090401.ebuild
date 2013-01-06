# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/driftnet/driftnet-0.1.6_p20090401.ebuild,v 1.8 2012/05/04 06:08:09 jdhore Exp $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A program which listens to network traffic and picks out images from TCP streams it observes"
HOMEPAGE="http://www.ex-parrot.com/~chris/driftnet/"
SRC_URI="mirror://github/rbu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
SLOT="0"
IUSE="gtk mp3 suid"

CDEPEND="net-libs/libpcap
	gtk? ( x11-libs/gtk+:2
		virtual/jpeg
		media-libs/giflib
		media-libs/libpng )"

DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	mp3? ( media-sound/mpg123 )"

src_prepare() {
	sed -i \
		-e 's:png_set_gray_1_2_4_to_8:png_set_expand_gray_1_2_4_to_8:' \
		png.c || die
}

src_compile() {
	export CC=$(tc-getCC)
	if use gtk; then
		emake || die "gtk+ build failed"
		mv driftnet driftnet-gtk
		make clean || die
	fi

	# build a non-gtk version for all users
	sed -i 's:^\(.*gtk.*\)$:#\1:g' Makefile || die "sed disable gtk failed"
	append-flags -DNO_DISPLAY_WINDOW
	emake || die "emake failed"
}

src_install () {
	dosbin driftnet || die "dobin failed"
	doman driftnet.1 || die "doman failed"

	use gtk && { dosbin driftnet-gtk || die "dosbin failed (gtk)" ; }

	dodoc CHANGES CREDITS README TODO || die "dodoc failed"

	if use suid ; then
		elog "marking the no-display driftnet as setuid root."
		fowners root:wheel "/usr/sbin/driftnet"
		fperms 710 "/usr/sbin/driftnet"
		fperms u+s "/usr/sbin/driftnet"
	fi
}
