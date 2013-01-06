# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jvyamlb/jvyamlb-0.2.2.ebuild,v 1.2 2009/01/05 22:02:16 maekke Exp $

EAPI="2"
JAVA_PKG_IUSE="source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="JvYAMLb, YAML processor extracted from JRuby"
HOMEPAGE="http://code.google.com/p/jvyamlb/"
SRC_URI="http://jvyamlb.googlecode.com/files/jvyamlb-src-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

CDEPEND="
	dev-java/bytelist:0
	dev-java/joda-time:0"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit )
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="bytelist joda-time"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -fv lib/*.jar || die

	# Don't do tests unnecessarily.
	sed -i 's:depends="test":depends="compile":' build.xml
}

src_install() {
	java-pkg_newjar lib/${P}.jar
	use source && java-pkg_dosrc src/*
}

src_test() {
	ANT_TASKS="ant-junit" eant test
}
