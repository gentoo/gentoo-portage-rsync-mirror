# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.4.11.1.ebuild,v 1.7 2012/12/08 12:04:16 dilfridge Exp $

EAPI=4

KMNAME="kdepim"
KDE_HANDBOOK=optional
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}
	!kde-misc/bilbo
	!kde-misc/blogilo
"

PATCHES=( "${FILESDIR}/${PN}"-4.4.10-nosoprano.patch )
