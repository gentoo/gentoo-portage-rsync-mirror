# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlstreambuffer/xmlstreambuffer-0.5.20070412-r1.ebuild,v 1.2 2014/08/10 20:27:40 slyfox Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_version_separator 2 '_')
DESCRIPTION="Mechanisms to create and processs stream buffers using standard XML APIs"
HOMEPAGE="https://xmlstreambuffer.dev.java.net/"
SRC_URI="https://xmlstreambuffer.dev.java.net/files/documents/4258/55235/StreamBufferPackage_src_${MY_PV}_033857.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/jsr173
	java-virtuals/jaf
	dev-java/stax-ex"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/streambuffer"

src_unpack() {

	unpack ${A}

	rm -vr "${S}/build" || die

	cd "${S}/dist"
	rm -v *.jar || die

	cd "${S}/lib"
	rm -v *.jar || die

	java-pkg_jar-from jsr173 jsr173.jar jsr173_api.jar
	java-pkg_jar-from stax-ex
	java-pkg_jar-from jaf
}

src_compile() {
	# This "clean" is needed!
	eant clean
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar dist/streambuffer.jar

	use source && java-pkg_dosrc src/*

}
