# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-2.9.2.ebuild,v 1.3 2014/01/28 16:47:27 nicolasbock Exp $

EAPI=5

#EANT_DOC_TARGET=javadocs
inherit java-pkg-2 java-ant-2

DESCRIPTION="Java GUI for managing BibTeX and other bibliographies"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/JabRef-${PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Removed doc USE flag, since the API documentation build system in this
# version is broken (see bug #497030). Reported the problem to upstream [1].
#
# [1] http://sourceforge.net/p/jabref/bugs/1203/

EANT_BUILD_TARGET="jars"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

src_install() {
	java-pkg_newjar build/lib/JabRef-${PV}.jar
	#use doc && java-pkg_dojavadoc build/docs/API
	#dodoc src/txt/README
	java-pkg_dolauncher ${PN} --main net.sf.jabref.JabRef
	newicon src/images/JabRef-icon-48.png JabRef-icon.png
	make_desktop_entry ${PN} JabRef JabRef-icon Office
}
