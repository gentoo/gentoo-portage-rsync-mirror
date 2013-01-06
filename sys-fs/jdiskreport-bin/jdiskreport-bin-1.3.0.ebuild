# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jdiskreport-bin/jdiskreport-bin-1.3.0.ebuild,v 1.2 2012/12/08 09:09:54 ulm Exp $

inherit java-pkg-2

MY_PN=${PN/-bin/}
MY_PV=${PV//\./_}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="JDiskReport helps you to understand disk drive usage"
HOMEPAGE="http://www.jgoodies.com/freeware/jdiskreport/index.html"
SRC_URI="http://www.jgoodies.com/download/${MY_PN}/${MY_P}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	java-pkg_newjar ${MY_PN}-${PV}.jar
	java-pkg_dolauncher ${MY_PN}

	dodoc README.txt RELEASE-NOTES.txt || die
}
