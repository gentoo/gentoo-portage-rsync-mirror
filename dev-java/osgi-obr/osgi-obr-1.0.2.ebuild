# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/osgi-obr/osgi-obr-1.0.2.ebuild,v 1.1 2013/10/15 22:59:31 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="org.osgi.service.obr"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="OSGi Service OBR by Apache"
HOMEPAGE="http://felix.apache.org"
SRC_URI="mirror://apache/dist/felix/${MY_P}-project.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND="dev-java/osgi-core-api:0"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}
	app-arch/unzip"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}"/${P}-build.xml build.xml || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="osgi-core-api"

src_install() {
	java-pkg_newjar target/${MY_P}.jar
}
