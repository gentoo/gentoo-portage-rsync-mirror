# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lastpass-cli/lastpass-cli-0.3.0.ebuild,v 1.3 2014/10/23 01:20:08 zerochaos Exp $

EAPI=5

DESCRIPTION="Interfaces with LastPass.com from the command line."
SRC_URI="https://github.com/lastpass/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/lastpass/lastpass-cli"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="X +pinentry"

RDEPEND="
	X? ( || ( x11-misc/xclip x11-misc/xsel ) )
	dev-libs/openssl
	net-misc/curl
	dev-libs/libxml2
	pinentry? ( app-crypt/pinentry )
"
DEPEND="${RDEPEND} app-text/asciidoc"

src_prepare() {
	sed -i 's/install -s/install/' Makefile || die "Could not remove stripping"
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
	emake PREFIX="${EPREFIX}/usr" doc-man
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install-doc
}
