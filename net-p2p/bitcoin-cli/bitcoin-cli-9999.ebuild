# Copyright 2010-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoin-cli/bitcoin-cli-9999.ebuild,v 1.1 2014/11/13 18:19:42 blueness Exp $

EAPI=4

inherit autotools eutils git-2

MyPV="${PV/_/}"
MyPN="bitcoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="Command-line JSON-RPC client specifically designed for talking to Bitcoin Core Daemon"
HOMEPAGE="http://bitcoin.org/"
SRC_URI="
"
EGIT_PROJECT='bitcoin'
EGIT_REPO_URI="git://github.com/bitcoin/bitcoin.git https://github.com/bitcoin/bitcoin.git"

LICENSE="MIT ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-libs/boost-1.52.0[threads(+)]
	dev-libs/openssl:0[-bindist]
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i 's/bitcoin-tx//' src/Makefile.am
	eautoreconf
}

src_configure() {
	econf \
		--disable-ccache \
		--without-miniupnpc  \
		--disable-tests  \
		--disable-wallet  \
		--without-daemon  \
		--without-gui
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc doc/README.md doc/release-notes.md
	dodoc doc/assets-attribution.md doc/tor.md
}
