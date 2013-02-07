# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.10.0.ebuild,v 1.1 2013/02/07 04:57:50 alexxy Exp $

EAPI=5

KMNAME="kde-workspace"
KMMODULE="libs/kworkspace"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml
"

KMSAVELIBS="true"

DEPEND="
	x11-libs/libxkbfile
	x11-libs/libXcomposite
"
RDEPEND=${DEPEND}

src_prepare() {
	sed -i -e 's/install( FILES kdisplaymanager.h/install( FILES kdisplaymanager.h screenpreviewwidget.h/' \
		libs/kworkspace/CMakeLists.txt || die "failed to provide screenpreviewwidget.h"

	kde4-meta_src_prepare
}
