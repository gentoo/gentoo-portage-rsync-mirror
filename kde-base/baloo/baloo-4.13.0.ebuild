# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/baloo/baloo-4.13.0.ebuild,v 1.7 2014/05/06 04:03:26 jmbsvicetto Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Next generation of the Nepomuk project"
KEYWORDS=" ~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +alternatekcm"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kfilemetadata)
	dev-libs/qjson
	=dev-libs/xapian-1.2*[chert]
	sys-apps/attr
	!<kde-base/nepomuk-4.12.50
"
RDEPEND="
	${DEPEND}
"
PDEPEND="alternatekcm? ( kde-misc/baloo-kcmadv )"

RESTRICT="test"

src_prepare() {
	kde4-base_src_prepare
	use alternatekcm && epatch "${FILESDIR}/${P}-nokcm.patch"
}
