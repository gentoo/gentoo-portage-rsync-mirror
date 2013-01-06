# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saaj/saaj-1.3-r1.ebuild,v 1.1 2008/10/05 20:20:57 serkan Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="SOAP with Attachments API for Java"
HOMEPAGE="https://saaj.dev.java.net/"
SRC_URI="https://saaj.dev.java.net/files/documents/52/32731/saaj${PV}.src.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="java-virtuals/saaj-api
	java-virtuals/jaf
	>=dev-java/xerces-2.8
	dev-java/xalan"
# needs com.sun.image.codec which 1.7 doesn't have
# should fix it to not use them at all
DEPEND="|| ( =virtual/jdk-1.6* =virtual/jdk-1.5* )
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}"

src_unpack() {

	unpack ${A}

	mkdir src lib || die
	mv com src || die

	cd "${S}/lib"
	java-pkg_jar-from --virtual saaj-api
	java-pkg_jar-from --virtual jaf
	java-pkg_jar-from xerces-2
	java-pkg_jar-from xalan

	cp -i "${FILESDIR}/build.xml-${PV}" "${S}/build.xml" || die

	cd "${S}/src"
	# YES! There's nothing like using com.sun...internal ! YAY!
	find . -name '*.java' -exec sed -i \
		-e 's,com.sun.org.apache.xerces.internal,org.apache.xerces,g' \
		-e 's,com.sun.org.apache.xalan.internal.xsltc.trax,org.apache.xalan.xsltc.trax,g' \
		{} \;

}

src_install() {
	java-pkg_dojar saaj.jar

	use source && java-pkg_dosrc src/*

}
