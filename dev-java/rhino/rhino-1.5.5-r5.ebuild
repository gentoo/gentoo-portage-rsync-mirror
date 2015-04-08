# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.5.5-r5.ebuild,v 1.4 2014/08/10 20:22:50 slyfox Exp $

JAVA_PKG_IUSE="doc source"
inherit eutils java-pkg-2 java-ant-2

MY_P="rhino1_5R5"
DESCRIPTION="Rhino is an open-source Java implementation of JavaScript"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip
	mirror://gentoo/rhino-swing-ex-1.0.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="1.5"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
DEPEND="dev-java/ant-core
	>=virtual/jdk-1.3
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.zip
	cd "${S}"
	mkdir build/
	epatch "${FILESDIR}/${PV}_jdk15.patch"
	epatch "${FILESDIR}/00_dont-fetch-swing-ex.patch"
	cp "${DISTDIR}/rhino-swing-ex-1.0.zip" build/swingExSrc.zip || die "unpack error"
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dolauncher jsscript-${SLOT} \
		--main org.mozilla.javascript.tools.shell.Main
	java-pkg_dojar build/*/js.jar
	use source && java-pkg_dosrc {src,toolsrc}/org
	use doc && java-pkg_dohtml -r docs/*
}
