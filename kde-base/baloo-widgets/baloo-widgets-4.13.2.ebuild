# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/baloo-widgets/baloo-widgets-4.13.2.ebuild,v 1.1 2014/06/15 16:56:17 kensington Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Widget library for baloo"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep kfilemetadata)
"
RDEPEND="${DEPEND}"
