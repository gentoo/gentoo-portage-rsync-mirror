# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calculator/calculator-1.6.43.ebuild,v 1.1 2011/08/06 21:33:45 bicatali Exp $

EAPI=4

inherit fox

DESCRIPTION="Scientific calculator based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/fox:1.6"
