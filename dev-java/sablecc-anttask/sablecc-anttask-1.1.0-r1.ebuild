# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sablecc-anttask/sablecc-anttask-1.1.0-r1.ebuild,v 1.4 2007/09/15 10:31:14 rbu Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ant task for sablecc"
HOMEPAGE="http://sablecc.org/"
SRC_URI="mirror://sourceforge/sablecc/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/sablecc
	>=dev-java/ant-core-1.7"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

src_install() {
	java-pkg_dojar lib/${PN}.jar
	java-pkg_register-ant-task
	dohtml doc/*
	dodoc AUTHORS ChangeLog README || die
}
