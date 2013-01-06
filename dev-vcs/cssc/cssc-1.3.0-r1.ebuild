# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cssc/cssc-1.3.0-r1.ebuild,v 1.7 2012/11/21 11:25:55 ago Exp $

EAPI=4
inherit eutils

DESCRIPTION="CSSC is the GNU Project's replacement for SCCS"
SRC_URI="mirror://gnu/${PN}/${P^^}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/cssc/"
SLOT="0"
LICENSE="GPL-3"
S="${WORKDIR}/${P^^}"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DOCS=( README NEWS ChangeLog AUTHORS )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc47.patch \
		"${FILESDIR}"/${P}-gets.patch

	# The large test takes a long time
	sed -i tests/Makefile.* \
		-e 's|\([[:space:]]\)test-large |\1|g' \
		|| die "sed failed"
}

src_configure() {
	econf --enable-binary --without-valgrind
}

src_compile() {
	emake all
}

src_test() {
	if [[ ${UID} = 0 ]]; then
		einfo "The test suite can not be run as root"
	else
		emake check
	fi
}
