# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jamon/jamon-1.01-r2.ebuild,v 1.1 2008/03/22 20:09:59 wltjr Exp $

EAPI=1
JAVA_PKG_IUSE="doc"
inherit java-pkg-2 java-ant-2 eutils

MY_PN="JAMon"
MY_PV="103005"
DESCRIPTION="Java API to monitor production applications"
HOMEPAGE="http://www.javaperformancetuning.com/tools/jamon/index.shtml"
SRC_URI="mirror://sourceforge/jamonapi/${MY_PN}All_${MY_PV}.zip"

LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	java-virtuals/servlet-api:2.3"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${RDEPEND}"

src_unpack() {
	# The structure of the archive is really messy, so we have to clean it up a
	# bit ourselves

	mkdir "${S}"
	cd "${S}"
	unpack ${A}
	rm ${MY_PN}.{j,w}ar
	epatch "${FILESDIR}"/${P}-java1.5.patch

	mv Code src

	# No provided ant script! Bad upstream, bad!
	cp "${FILESDIR}"/build-1.0.xml build.xml
}

src_compile() {
	eant jar $(use_doc) \
		-Dproject.name=${PN} \
		-Dclasspath=$(java-pkg_getjars servlet-api-2.3)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dojavadoc dist/doc/api
}
