# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pastebin/pastebin-0.6.2-r1.ebuild,v 1.6 2012/02/02 10:25:15 jlec Exp $

EAPI=4

inherit eutils perl-app

DESCRIPTION="CLI to pastebin.com"
HOMEPAGE="http://code.google.com/p/pastebin-cli/"
SRC_URI="http://pastebin-cli.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/libwww-perl"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-lnot-specified.patch
}

src_install() {
	dobin ${PN}
}
