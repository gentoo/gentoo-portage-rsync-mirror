# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yacas/yacas-1.3.4.ebuild,v 1.1 2014/05/28 17:44:49 bicatali Exp $

EAPI=5

inherit autotools-utils java-pkg-opt-2

DESCRIPTION="General purpose computer algebra system"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz"

SLOT="0/1"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc java static-libs server"

DEPEND="java? ( >=virtual/jdk-1.6 )"
RDEPEND="java? ( >=virtual/jre-1.6 )"

src_configure() {
	local myeconfargs=(
		$(use_enable doc html-doc)
		$(use_enable server)
		--with-html-dir="/usr/share/doc/${PF}/html"
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use java; then
		cd "${BUILD_DIR}"/JavaYacas || die
		# -j1 because of file generation dependence
		emake -j1 -f makefile.yacas
	fi
}

src_install() {
	autotools-utils_src_install
	if use java; then
		cd "${BUILD_DIR}}"/JavaYacas || die
		java-pkg_dojar yacas.jar
		java-pkg_dolauncher jyacas --main net.sf.yacas.YacasConsole
		insinto /usr/share/${PN}
		doins "${S}"/JavaYacas/{hints.txt,yacasconsole.html}
	fi
}
