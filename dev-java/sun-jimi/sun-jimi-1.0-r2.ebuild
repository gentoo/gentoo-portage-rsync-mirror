# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jimi/sun-jimi-1.0-r2.ebuild,v 1.8 2011/12/31 16:43:00 sera Exp $

inherit java-pkg-2

DESCRIPTION="Jimi is a class library for managing images."
HOMEPAGE="http://java.sun.com/products/jimi/"
SRC_URI="jimi1_0.zip"
LICENSE="sun-bcla-jimi"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"
RESTRICT="fetch"

S=${WORKDIR}/Jimi

DOWNLOAD_URL="http://java.sun.com/products/jimi/"

pkg_nofetch() {
	einfo "Please download ${A} from the following url and place it in ${DISTDIR}"
	einfo "${DOWNLOAD_URL} "
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf src/classes/*
}

src_compile() {
	cd "${S}/src"
	ejavac -classpath . -d classes $(cat main_classes.txt) || die "failes to	compile"
	jar -cf ${PN}.jar -C classes . || die "failed to create jar"
}

src_install() {
	java-pkg_dojar src/${PN}.jar

	dodoc Readme
	use doc && java-pkg_dohtml -r docs/*
}
