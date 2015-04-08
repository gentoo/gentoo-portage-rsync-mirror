# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/epkg/epkg-0.2.ebuild,v 1.1 2013/01/09 03:30:14 jdhore Exp $

EAPI=4

DESCRIPTION="A simple portage wrapper which works like other package managers"
HOMEPAGE="http://github.com/jdhore/epkg"
SRC_URI="https://github.com/jdhore/${PN}/archive/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${P}"
DEPEND=""
RDEPEND="app-portage/eix
		app-portage/gentoolkit
		sys-apps/portage"

src_install() {
	dobin epkg
}
