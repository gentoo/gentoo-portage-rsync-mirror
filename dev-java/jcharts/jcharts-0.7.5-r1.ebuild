# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcharts/jcharts-0.7.5-r1.ebuild,v 1.3 2009/09/05 22:26:05 maekke Exp $

EAPI="1"
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

MY_P="jCharts-${PV}"
DESCRIPTION="jCharts is a 100% Java based charting utility that outputs a variety of charts"
HOMEPAGE="http://jcharts.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

COMMON_DEP="dev-java/batik:1.7
			dev-java/servletapi:2.4"

RDEPEND=">=virtual/jre-1.4
		${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
		${COMMON_DEP}
		app-arch/unzip"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.{jar,war} lib/*.jar
}

_eant() {
	cd build
	local servletcp="$(java-pkg_getjars servletapi-2.4)"
	eant ${1} \
		-Dbatik.classpath="$(java-pkg_getjars batik-1.7):${servletcp}"
}

src_compile() {
	# zip file includes javadocs and 1.6 fails to generate them so we just use
	# the bundled ones
	_eant jar
}

RESTRICT=test
# tests need X11
#src_test() {
#	_eant test
#}

src_install() {
	java-pkg_newjar build/*.jar
	dohtml docs/*.html
	use doc && java-pkg_dojavadoc javadocs
	use source && java-pkg_dosrc src/org
	use examples && java-pkg_doexamples demo
}
