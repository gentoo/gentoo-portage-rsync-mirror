# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.5.1.ebuild,v 1.3 2012/02/24 14:15:53 phajdan.jr Exp $

EAPI="4"

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="mirror://sourceforge/ink/${P/_}.tar.gz"
HOMEPAGE="http://ink.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">net-print/libinklevel-0.8"
RDEPEND="${DEPEND}"
