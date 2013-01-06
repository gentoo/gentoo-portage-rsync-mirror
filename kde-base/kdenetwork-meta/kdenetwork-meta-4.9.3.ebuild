# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-4.9.3.ebuild,v 1.4 2012/11/30 15:43:19 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="ppp"

RDEPEND="
	$(add_kdebase_dep kdenetwork-filesharing)
	$(add_kdebase_dep kdnssd)
	$(add_kdebase_dep kget)
	$(add_kdebase_dep kopete)
	$(add_kdebase_dep krdc)
	$(add_kdebase_dep krfb)
	ppp? ( $(add_kdebase_dep kppp) )
"
