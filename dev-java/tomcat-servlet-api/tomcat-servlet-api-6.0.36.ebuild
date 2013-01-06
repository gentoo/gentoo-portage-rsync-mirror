# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tomcat-servlet-api/tomcat-servlet-api-6.0.36.ebuild,v 1.6 2012/12/31 21:17:12 grobian Exp $

EAPI="2"
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

MY_A="apache-${P}-src"
MY_P="${MY_A/-servlet-api/}"
DESCRIPTION="Tomcat's Servlet API 2.5/JSP API 2.1 implementation"
HOMEPAGE="http://tomcat.apache.org/"
SRC_URI="mirror://apache/tomcat/tomcat-6/v${PV}/src/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2.5"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${MY_P}/"

java_prepare() {
	cp "${FILESDIR}/${SLOT}-build.xml" build.xml || die "Could not replace build.xml"
	rm */*/build.xml
}

src_install() {
	java-pkg_dojar "${S}"/output/build/lib/*.jar
	use source && java-pkg_dosrc java/javax/servlet/
}
