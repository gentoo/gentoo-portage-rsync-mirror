# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/adie/adie-1.6.36.ebuild,v 1.7 2010/07/27 01:34:17 jer Exp $

EAPI="1"

inherit fox

DESCRIPTION="Text editor based on the FOX Toolkit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND="x11-libs/fox:1.6"

RDEPEND="${DEPEND}"
