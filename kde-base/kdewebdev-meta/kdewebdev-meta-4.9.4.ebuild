# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev-meta/kdewebdev-meta-4.9.4.ebuild,v 1.2 2012/12/25 11:31:53 maekke Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="KDE WebDev - merge this to pull in all kdewebdev-derived packages"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kfilereplace)
	$(add_kdebase_dep kimagemapeditor)
	$(add_kdebase_dep klinkstatus)
	$(add_kdebase_dep kommander)
"
