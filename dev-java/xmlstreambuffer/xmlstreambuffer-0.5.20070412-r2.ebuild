# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlstreambuffer/xmlstreambuffer-0.5.20070412-r2.ebuild,v 1.3 2011/12/21 08:41:53 phajdan.jr Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_version_separator 2 '_')
DESCRIPTION="Mechanisms to create and processs stream buffers using standard XML APIs."
HOMEPAGE="https://xmlstreambuffer.dev.java.net/"
SRC_URI="https://xmlstreambuffer.dev.java.net/files/documents/4258/55235/StreamBufferPackage_src_${MY_PV}_033857.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="java-virtuals/stax-api
	java-virtuals/jaf
	dev-java/stax-ex"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/streambuffer"

EANT_GENTOO_CLASSPATH="stax-api,jaf,stax-ex"

src_unpack() {

	unpack ${A}

	rm -vr "${S}/build" || die

	cd "${S}/dist" || die
	rm -v *.jar || die

	cd "${S}/lib" || die
	rm -v *.jar || die
	cd "${S}" || die
	java-ant_rewrite-classpath nbproject/build-impl.xml
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
