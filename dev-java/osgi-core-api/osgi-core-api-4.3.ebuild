# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/osgi-core-api/osgi-core-api-4.3.ebuild,v 1.3 2012/05/09 17:09:40 phajdan.jr Exp $

EAPI=4

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Service Platform Core API (Companion Code)"
HOMEPAGE="http://www.osgi.org/Specifications/HomePage"
SRC_URI="http://www.osgi.org/download/r4v${PV//./}/osgi.core.jar -> ${P}-all.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>=virtual/jre-1.5"
DEPEND="
	>=virtual/jdk-1.5
	app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"

java_prepare() {
	rm -r org || die
}
