# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-4.4.11.1-r1.ebuild,v 1.7 2012/12/08 12:04:13 dilfridge Exp $

EAPI=4

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdelibs '' 4.6)
	$(add_kdebase_dep kdepimlibs '' 4.6)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}"-4.4.11.1-revert.patch
)

KMLOADLIBS="libkdepim"
