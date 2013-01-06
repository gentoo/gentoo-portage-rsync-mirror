# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrobin/jrobin-1.5.4.ebuild,v 1.2 2007/09/18 06:36:31 wltjr Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JRobin is a 100% pure Java alternative to RRDTool"

SRC_URI="mirror://sourceforge/jrobin/${P}-1.tar.gz"
HOMEPAGE="http://www.jrobin.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

SLOT="0"

RDEPEND=">=virtual/jre-1.5"

DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/JRobinLite-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	einfo "Removing bundled jars and classes"
	find "${S}" '(' -name '*.class' -o -name '*.jar' ')' -print -delete
}

EANT_BUILD_XML="ant/build.xml"
EANT_BUILD_TARGET="${PN}"

src_install() {
	jars="convertor inspector ${PN}"
	for jar in ${jars} ; do
		java-pkg_newjar "${S}/lib/${jar}-${PV}.jar" ${jar}.jar
	done
	use source && java-pkg_dosrc src
	use doc && java-pkg_dojavadoc doc/javadoc
}
