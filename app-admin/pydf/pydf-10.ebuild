# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pydf/pydf-10.ebuild,v 1.6 2012/10/16 21:59:28 maekke Exp $

EAPI=4

PYTHON_DEPEND="*"

inherit python

DESCRIPTION="Enhanced df with colors"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/pydf/"
SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/pydf/${PN}_${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	sed -i -e "s:/etc/pydfrc:${EPREFIX}/etc/pydfrc:" pydf || die
}

src_install() {
	dobin pydf
	insinto /etc
	doins pydfrc
	doman pydf.1
	dodoc README
}
