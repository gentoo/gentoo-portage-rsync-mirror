# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/osgi-core-api/osgi-core-api-4.3.ebuild,v 1.4 2013/07/16 12:06:16 tomwij Exp $

EAPI=4

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Service Platform Core API (Companion Code)"
HOMEPAGE="http://www.osgi.org/Specifications/HomePage"
SRC_URI="http://www.osgi.org/download/r4v${PV//./}/osgi.core-${PV}.0.jar -> ${P}-all.zip"

LICENSE="Apache-2.0 OSGi-Specification-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="bindist fetch"

RDEPEND="
	>=virtual/jre-1.5"
DEPEND="
	>=virtual/jdk-1.5
	app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"

pkg_nofetch() {
	einfo "Please download osgi.core-${PV}.jar from"
	einfo "  http://www.osgi.org/Download/Release4V43"
	einfo "which you can find listed as"
	einfo "  OSGi Service Platform Release 4 Version 4.3 Core Companion Code 4.3.0"
	einfo "after accepting the license."
}

java_prepare() {
	rm -r org || die
}
