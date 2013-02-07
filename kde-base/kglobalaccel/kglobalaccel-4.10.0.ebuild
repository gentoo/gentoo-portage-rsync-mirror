# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kglobalaccel/kglobalaccel-4.10.0.ebuild,v 1.1 2013/02/07 04:57:39 alexxy Exp $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE's Global Shortcut Daemon"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

src_configure() {
	mycmakeargs=(
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_DESKTOP_FILE=NOTFOUND
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_PLUGIN=NOTFOUND
	)

	kde4-meta_src_configure
}
