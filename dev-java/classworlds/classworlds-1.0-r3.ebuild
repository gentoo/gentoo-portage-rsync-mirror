# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/classworlds/classworlds-1.0-r3.ebuild,v 1.2 2008/03/22 22:53:18 betelgeuse Exp $

EAPI=1

inherit java-pkg-2 java-ant-2

DESCRIPTION="Advanced classloader framework"
HOMEPAGE="http://dist.codehaus.org/classworlds/distributions/classworlds-1.0-src.tar.gz"
SRC_URI="http://dist.codehaus.org/classworlds/distributions/${P}-src.tar.gz"
LICENSE="codehaus-classworlds"
SLOT="1"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.4
	dev-java/xerces:2"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

# They fail
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}/build-${PV}.xml" "${S}/build.xml" || die
	mkdir -p "${S}/target/lib"

	cd "${S}/target/lib"

	java-pkg_jar-from xerces-2
}

EANT_TEST_JUNIT_INTO="target/lib"

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
}
