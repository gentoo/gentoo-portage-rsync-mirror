# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcrafter/libcrafter-9999.ebuild,v 1.1 2014/06/26 22:08:22 jer Exp $

EAPI=5
inherit autotools eutils git-r3

DESCRIPTION="a high level library for C++ designed to make easier the creation and decoding of network packets"
HOMEPAGE="https://code.google.com/p/libcrafter/"
EGIT_REPO_URI="https://github.com/pellegre/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="pcap static-libs"

DEPEND="
	pcap? ( net-libs/libpcap )
"

S=${WORKDIR}/${P}/${PN}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with pcap libpcap)
}

src_install() {
	default

	prune_libtool_files
}
