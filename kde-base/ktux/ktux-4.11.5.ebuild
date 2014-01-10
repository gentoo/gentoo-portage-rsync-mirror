# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.11.5.ebuild,v 1.1 2014/01/10 04:22:20 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
HOMEPAGE+=" http://userbase.kde.org/KTux"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# libkworkspace - only as a stub to provide KDE4Workspace config
DEPEND="
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}"
