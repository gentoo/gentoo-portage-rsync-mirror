# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jrdesktop/jrdesktop-0.2.0030.ebuild,v 1.2 2009/06/29 21:06:27 maekke Exp $

JAVA_PKG_IUSE="source doc"
WANT_ANT_TASKS="ant-nodeps"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java Remote Desktop (jrdesktop) software for viewing and/or controlling a distance PC."
HOMEPAGE="http://jrdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${P}.src/${PN}"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

src_install() {
	java-pkg_dojar "dist/${PN}.jar"

	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc dist/javadoc

	java-pkg_dolauncher
}
