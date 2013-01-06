# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ldapsdk/ldapsdk-4.1.7-r2.ebuild,v 1.4 2007/02/03 16:06:21 beandog Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netscape Directory SDK for Java"
HOMEPAGE="http://www.mozilla.org/directory/javasdk.html"
SRC_URI="http://www.mozilla.org/directory/${PN}_java_20020819.tar.gz"

LICENSE="MPL-1.1"
SLOT="4.1"
KEYWORDS="amd64 x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	dev-java/jss
	=dev-java/jakarta-oro-2.0*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.6.2"

S=${WORKDIR}/mozilla/directory/java-sdk

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}/mozilla
	epatch ${FILESDIR}/ldapsdk-gentoo.patch

	cd ${S}
	echo "ororegexp.jar=$(java-pkg_getjars jakarta-oro-2.0)" > build.properties
	echo "jss.jar=$(java-pkg_getjars jss-3.4)" >> build.properties

	cd ${S}/ldapjdk/lib
	rm -f *.jar
	java-pkg_jar-from jss-3.4

	cd ${S}/ldapsp/lib
	rm *.jar

	java-pkg_filter-compiler jikes
}

src_compile() {
	eant dist-jdk dist-filter dist-beans dist-jndi $(use_doc build-docs)
}

src_install() {
	java-pkg_dojar dist/packages/*.jar

	use doc && java-pkg_dojavadoc dist/doc/ldapsp
	use source && \
		java-pkg_dosrc {ldapsp,ldapjdk}/com	{ldapjdk,ldapbeans,ldapfilter}/netscape
}
