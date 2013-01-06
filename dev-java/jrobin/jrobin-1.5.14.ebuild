# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrobin/jrobin-1.5.14.ebuild,v 1.1 2012/05/07 08:24:39 sera Exp $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JRobin is a 100% pure Java alternative to RRDTool"
HOMEPAGE="http://www.jrobin.org/"
SRC_URI="mirror://sourceforge/jrobin/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Require jdk6. #402485
RDEPEND="virtual/jre:1.6"
DEPEND="virtual/jdk:1.6"

java_prepare() {
	find -name '*.jar' -exec rm -v {} + || die
}

EANT_BUILD_XML="ant/build.xml"
EANT_BUILD_TARGET="${PN}"

src_install() {
	for jar in convertor inspector ${PN}; do
		java-pkg_newjar lib/${jar}-*.jar ${jar}.jar
	done
	java-pkg_dolauncher ${PN} --main org.jrobin.cmd.RrdCommander

	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc doc/javadoc
}
