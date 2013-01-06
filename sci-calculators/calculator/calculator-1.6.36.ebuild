# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calculator/calculator-1.6.36.ebuild,v 1.5 2010/07/27 01:33:35 jer Exp $

EAPI="1"

inherit fox

DESCRIPTION="Scientific calculator based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/fox:1.6"
