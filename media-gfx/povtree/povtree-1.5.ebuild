# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povtree/povtree-1.5.ebuild,v 1.8 2009/11/25 22:20:51 maekke Exp $

S="${WORKDIR}"
MY_P="${PN}${PV}"
DESCRIPTION="Tree generator for POVray based on TOMTREE macro"
HOMEPAGE="http://propro.ru/go/Wshop/povtree/povtree.html"
SRC_URI="http://propro.ru/go/Wshop/povtree/${MY_P}.zip"

KEYWORDS="amd64 ppc x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/jre-1.3"
DEPEND="app-arch/unzip"

src_install() {
	# wrapper
	dobin "${FILESDIR}"/povtree || die "dobin failed"
	# package
	insinto /usr/lib/povtree
	doins povtree.jar || die "doins failed"
	dodoc TOMTREE-${PV}.inc help.jpg || die "dodoc failed"
}
