# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-4.10.5.ebuild,v 1.5 2013/08/02 14:29:27 ago Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kcron)
	$(add_kdebase_dep ksystemlog)
	$(add_kdebase_dep kuser)
"
