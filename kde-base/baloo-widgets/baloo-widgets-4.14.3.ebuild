# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/baloo-widgets/baloo-widgets-4.14.3.ebuild,v 1.3 2015/02/14 14:35:01 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Widget library for baloo"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep kfilemetadata)
"
RDEPEND="${DEPEND}"
