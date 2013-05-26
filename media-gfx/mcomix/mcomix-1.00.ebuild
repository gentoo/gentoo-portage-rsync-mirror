# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mcomix/mcomix-1.00.ebuild,v 1.1 2013/05/26 07:19:54 dirtyepic Exp $

EAPI="5"

PYTHON_COMPAT=( python2_6 python2_7 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 eutils fdo-mime

DESCRIPTION="A fork of comix, a GTK image viewer for comic book archives."
HOMEPAGE="http://mcomix.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/imaging-1.1.5[${PYTHON_USEDEP}]
	>=dev-python/pygtk-2.14[${PYTHON_USEDEP}]
	virtual/jpeg
	x11-libs/gdk-pixbuf
	!media-gfx/comix"

DOCS=( ChangeLog README )

python_install_all() {
	distutils-r1_python_install_all
	insinto /etc/gconf/schemas/
	doins "${S}"/mime/comicbook.schemas
	dobin "${S}"/mime/comicthumb
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	echo
	elog "Additional packages are required to open most common comic files:"
	elog
	elog "    cbr: app-arch/unrar"
	elog "    cbz: app-arch/unzip"
	elog
	elog "You can also add support for 7z or LHA archives by installing"
	elog "app-arch/p7zip or app-arch/lha."
	echo
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
