# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.50_pre2-r1.ebuild,v 1.1 2012/07/06 07:28:37 jlec Exp $

EAPI=4

inherit eutils flag-o-matic toolchain-funcs

MY_P="${PN}-${PV/_pre/-PR}"

DESCRIPTION="Identify/delete duplicate files residing within specified directories"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${PN}/beta/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-compare-file.patch \
		"${FILESDIR}"/${P}-lfs.patch \
		"${FILESDIR}"/${P}-typo.patch

	append-lfs-flags
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin fdupes
	doman fdupes.1
	dodoc CHANGES CONTRIBUTORS README TODO
}
