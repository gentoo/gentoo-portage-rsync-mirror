# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/safecopy/safecopy-1.6.ebuild,v 1.2 2011/05/31 10:22:47 scarabeus Exp $

EAPI=4

inherit base

DESCRIPTION="Data recovery tool to fault-tolerantly extract data from damaged (io-errors) devices or files."
HOMEPAGE="http://safecopy.sourceforge.net"
SRC_URI="mirror://sourceforge/safecopy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=""
DEPEND=""

DOCS=( README )

src_prepare() {
	base_src_prepare
	sed -e 's:bin/sh:bin/bash:' \
		-i "${S}"/test/test.sh || die
}

src_configure() {
	default_src_configure
	if use test; then
		cd "${S}"/simulator
		default_src_configure
	fi
}

src_compile() {
	default_src_compile
	if use test; then
		cd "${S}"/simulator
		default_src_compile
	fi
}

src_test() {
	cd "${S}"/test
	./test.sh || die
}
