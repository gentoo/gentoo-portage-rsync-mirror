# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povtree/povtree-1.5-r1.ebuild,v 1.1 2013/07/24 03:38:48 ottxor Exp $

EAPI=5

S="${WORKDIR}"
MY_P="${PN}${PV}"
DESCRIPTION="Tree generator for POVray based on TOMTREE macro"
HOMEPAGE="http://propro.ru/go/Wshop/povtree/povtree.html"
SRC_URI="http://propro.ru/go/Wshop/povtree/${MY_P}.zip"

KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/jre-1.3"
DEPEND="app-arch/unzip"

src_install() {
	# wrapper
	sed "s:/usr/:${EPREFIX}&:" "${FILESDIR}"/povtree > "${T}"/povtree || die
	dobin "${T}"/povtree
	# package
	insinto /usr/lib/povtree
	doins povtree.jar
	dodoc TOMTREE-${PV}.inc help.jpg
}
