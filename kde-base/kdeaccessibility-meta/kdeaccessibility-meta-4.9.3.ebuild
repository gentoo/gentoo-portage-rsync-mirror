# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-4.9.3.ebuild,v 1.4 2012/11/30 15:32:46 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep jovie)
	$(add_kdebase_dep kaccessible)
	$(add_kdebase_dep kmag)
	$(add_kdebase_dep kmousetool)
	$(add_kdebase_dep kmouth)
"
