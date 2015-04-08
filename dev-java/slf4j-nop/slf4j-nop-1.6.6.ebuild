# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/slf4j-nop/slf4j-nop-1.6.6.ebuild,v 1.1 2012/08/03 21:20:23 caster Exp $

EAPI="4"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.slf4j.org/dist/${P/-nop/}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

COMMON_DEP="~dev-java/slf4j-api-${PV}:0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

S="${WORKDIR}/${P/-api/}"

EANT_GENTOO_CLASSPATH="slf4j-api"

S="${WORKDIR}/${P/-nop/}"

java_prepare() {
	cp -v "${FILESDIR}"/${PV}-build.xml build.xml || die

	# for ecj-3.5
	java-ant_rewrite-bootclasspath auto

	cd "${S}"
	rm *.jar integration/lib/*.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc org
}
