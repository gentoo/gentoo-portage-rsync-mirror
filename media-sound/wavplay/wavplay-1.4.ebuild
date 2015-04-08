# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavplay/wavplay-1.4.ebuild,v 1.16 2010/04/10 02:57:12 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A command line player/recorder for wav files"
HOMEPAGE="http://sourceforge.net/projects/wavplay/"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/players/${P}.tar.gz
	mirror://gentoo/${P}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 -sparc x86"
IUSE=""

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/${P}.patch
	epatch "${FILESDIR}"/${P}-gcc34.patch
	sed -i -e 's:ln :ln -s :' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CP="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" CCFLAGS="${CXXFLAGS}" LDOPTS="${LDFLAGS}" no_x || die
}

src_install() {
	dodir /usr/bin
	emake INSTDIR="${D}/usr/bin" install_no_x || die
	# the motif frontend crashes and there are nicer player
	# for X anyway
	# no suid root install for old packages which use strcpy
	dodoc BUGS README
	doman *.1
}
