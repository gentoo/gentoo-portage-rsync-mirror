# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcrafter/libcrafter-9999.ebuild,v 1.2 2014/11/29 12:08:21 jer Exp $

EAPI=5
inherit autotools eutils git-r3

DESCRIPTION="a high level library for C++ designed to make easier the creation and decoding of network packets"
HOMEPAGE="https://code.google.com/p/libcrafter/"
EGIT_REPO_URI="https://github.com/pellegre/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

RDEPEND="
	net-libs/libpcap
"
DEPEND="
	${RDEPEND}
"

S=${WORKDIR}/${P}/${PN}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default

	prune_libtool_files
}
