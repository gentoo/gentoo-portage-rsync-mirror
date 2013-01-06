# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/epkg/epkg-0.1.ebuild,v 1.1 2012/05/20 18:40:07 jdhore Exp $

EAPI=4

DESCRIPTION="A simple portage wrapper which works like other package managers"
HOMEPAGE="http://github.com/jdhore/epkg"
SRC_URI="mirror://github/jdhore/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-portage/eix
		app-portage/gentoolkit
		sys-apps/portage"

src_install() {
	dobin epkg
}
