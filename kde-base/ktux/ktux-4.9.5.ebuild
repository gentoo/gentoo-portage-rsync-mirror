# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.9.5.ebuild,v 1.1 2013/01/05 20:18:46 creffett Exp $

EAPI=4

KMNAME="kdetoys"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# libkworkspace - only as a stub to provide KDE4Workspace config
DEPEND="
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}"
