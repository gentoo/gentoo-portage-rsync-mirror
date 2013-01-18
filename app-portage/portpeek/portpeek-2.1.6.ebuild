# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-2.1.6.ebuild,v 1.1 2013/01/18 14:08:39 mpagano Exp $

EAPI="4"
PYTHON_DEPEND="*:2.7"

inherit python

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-portage/gentoolkit-0.3.0.7
	>=sys-apps/portage-2.1.11.31"

src_install() {
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}
