# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cos/cos-20021105-r2.ebuild,v 1.2 2012/06/05 14:28:17 sera Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

MY_PV=05Nov2002
MY_P=${PN}-${MY_PV}
DESCRIPTION="The com.oreilly.servlet package is a class library for servlet developers."
HOMEPAGE="http://servlets.com/cos/"
SRC_URI="http://servlets.com/${PN}/${MY_P}.zip"

LICENSE="cos"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	java-virtuals/servlet-api:2.3"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${RDEPEND}"
S=${WORKDIR}

src_unpack() {
	unpack ${A}

	rm -r lib classes *.war
	# TODO I'm not sure how to fix the compilation error for this class
	# so i'll just delete it for now..
	rm src/com/oreilly/servlet/CacheHttpServlet.java

	cp "${FILESDIR}"/build-${PV}.xml build.xml
	cat > build.properties <<-EOF
		classpath=$(java-pkg_getjars servlet-api-2.3)
	EOF
}

src_compile() {
	eant -Dproject.name=${PN} jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc readme.txt license.txt || die

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/com
}
