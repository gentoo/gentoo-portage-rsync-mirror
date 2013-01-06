# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/libydpdict/libydpdict-1.0.2.ebuild,v 1.1 2009/10/18 09:12:09 spock Exp $

DESCRIPTION="Library for handling the Collins Dictionary database."
HOMEPAGE="http://toxygen.net/ydpdict/"
SRC_URI="http://toxygen.net/ydpdict/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS
}
