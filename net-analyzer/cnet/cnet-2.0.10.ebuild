# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cnet/cnet-2.0.10.ebuild,v 1.4 2009/01/15 05:02:55 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Network simulation tool"
SRC_URI="http://www.csse.uwa.edu.au/cnet/${P}.tgz"
HOMEPAGE="http://www.csse.uwa.edu.au/cnet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/tk-8.3.4
	dev-libs/elfutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	# these directories aren't created during the make install
	# process, so we'll need to make them beforehand, or else
	# we'll have nowhere to put the files
	mkdir -p "${D}"/usr/{bin,lib,share}
	mkdir -p "${D}"/usr/share/man/man1
	# install with make now
	make PREFIX="${D}"/usr install || die

	#install examples
	docinto EXAMPLES
	dodoc EXAMPLES/*
}
