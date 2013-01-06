# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ifuse/ifuse-1.1.2.ebuild,v 1.3 2012/08/16 22:03:32 johu Exp $

EAPI=4

DESCRIPTION="Mount Apple iPhone/iPod Touch file systems for backup purposes"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.1.4
	>=app-pda/libplist-1.8
	>=sys-fs/fuse-2.7.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README"

pkg_postinst() {
	ewarn "Only use this filesystem driver to create backups of your data."
	ewarn "The music database is hashed, and attempting to add files will "
	ewarn "cause the iPod/iPhone to consider your database unauthorised."
	ewarn "It will respond by wiping all media files, requiring a restore "
	ewarn "through iTunes. You have been warned."
}
