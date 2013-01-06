# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-bjnp/cups-bjnp-1.1.ebuild,v 1.1 2012/10/25 11:09:30 scarabeus Exp $

EAPI=5

DESCRIPTION="CUPS backend for the canon printers using the proprietary USB over IP BJNP protocol."
HOMEPAGE="http://sourceforge.net/projects/cups-bjnp/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"
