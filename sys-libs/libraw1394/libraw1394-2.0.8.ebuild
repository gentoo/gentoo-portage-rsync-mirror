# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-2.0.8.ebuild,v 1.8 2012/09/02 18:22:55 armin76 Exp $

EAPI=4

DESCRIPTION="library that provides direct access to the IEEE 1394 bus"
HOMEPAGE="http://ieee1394.wiki.kernel.org/"
SRC_URI="mirror://kernel/linux/libs/ieee1394/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="static-libs"

DEPEND="app-arch/xz-utils"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf \
		--without-fw-dir \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
