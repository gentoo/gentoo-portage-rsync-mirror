# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcs/jcs-1.3-r1.ebuild,v 1.7 2014/09/04 04:53:25 ercpe Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JCS is a distributed caching system written in java for server-side java applications"
HOMEPAGE="http://commons.apache.org/jcs/"
SRC_URI="mirror://apache/jakarta/jcs/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="1.3"
KEYWORDS="amd64 ppc x86"
IUSE="admin"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-lang:0
	dev-java/jisp:2.5
	java-virtuals/servlet-api:2.3
	dev-db/hsqldb
	dev-java/commons-dbcp:0
	dev-java/commons-logging:0
	dev-java/commons-pool:0
	dev-java/concurrent-util:0
	dev-java/xmlrpc:0
	admin? ( dev-java/velocity )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"
JAVA_PKG_FILTER_COMPILER="jikes"

LIBRARY_PKGS="servlet-api-2.3,commons-lang,commons-logging,commons-pool,commons-dbcp,xmlrpc,concurrent-util,jisp-2.5,hsqldb"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# use our own build.xml because jcs's is demented by maven
	cp "${FILESDIR}/build-${PV}.xml" build.xml

	if use admin; then
		LIBRARY_PKGS="${LIBRARY_PKGS},velocity"
	else
		rm -fr "${S}/src/java/org/apache/jcs/admin"
	fi

	cat > build.properties <<-END
		classpath=$(java-pkg_getjars ${LIBRARY_PKGS})
	END
}

src_compile() {
	eant jar -Dproject.name=${PN} $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/java/*
}
