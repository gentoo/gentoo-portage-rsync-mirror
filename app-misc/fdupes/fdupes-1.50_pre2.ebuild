# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.50_pre2.ebuild,v 1.11 2011/10/12 16:50:09 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs

MY_P="${PN}-${PV/_pre/-PR}"

DESCRIPTION="Identify/delete duplicate files residing within specified directories"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${PN}/beta/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin fdupes
	doman fdupes.1
	dodoc CHANGES CONTRIBUTORS README TODO
}
