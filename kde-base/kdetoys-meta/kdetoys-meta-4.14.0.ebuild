# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.14.0.ebuild,v 1.1 2014/08/20 16:02:51 johu Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE+=" http://techbase.kde.org/Projects/Kdetoys"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep amor)
	$(add_kdebase_dep kteatime)
	$(add_kdebase_dep ktux)
"
