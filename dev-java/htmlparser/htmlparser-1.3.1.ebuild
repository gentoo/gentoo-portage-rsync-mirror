# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/htmlparser/htmlparser-1.3.1.ebuild,v 1.1 2012/02/23 20:15:28 nelchael Exp $

EAPI=4

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Implementation of the HTML5 parsing algorithm in Java"
HOMEPAGE="http://about.validator.nu/htmlparser/"
SRC_URI="http://about.validator.nu/${PN}/${P}.zip"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="dev-java/icu4j:4
	dev-java/xom
	dev-java/jchardet"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

src_prepare() {
	rm -f *.jar
	mkdir -p "${S}/build" || die "mkdir failed"
	mkdir -p "${S}/lib" || die "mkdir failed"

	cp "${FILESDIR}/build.xml" "${S}" || die "cp failed"

	java-pkg_jarfrom --into lib/ icu4j-4
	java-pkg_jarfrom --into lib/ xom
	java-pkg_jarfrom --into lib/ jchardet
}

src_install() {
	java-pkg_dojar htmlparser.jar

	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc docs
}
