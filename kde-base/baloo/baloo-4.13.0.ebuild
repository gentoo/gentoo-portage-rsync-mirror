# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/baloo/baloo-4.13.0.ebuild,v 1.3 2014/04/17 22:31:11 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Next generation of the Nepomuk project"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kfilemetadata)
	dev-libs/qjson
	=dev-libs/xapian-1.2*
	sys-apps/attr
	!<kde-base/nepomuk-4.12.50
"
RDEPEND="${DEPEND}"

RESTRICT="test"
