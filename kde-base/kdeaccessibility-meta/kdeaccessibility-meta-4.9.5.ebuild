# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility-meta/kdeaccessibility-meta-4.9.5.ebuild,v 1.4 2013/01/27 23:11:31 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep jovie)
	$(add_kdebase_dep kaccessible)
	$(add_kdebase_dep kmag)
	$(add_kdebase_dep kmousetool)
	$(add_kdebase_dep kmouth)
"
