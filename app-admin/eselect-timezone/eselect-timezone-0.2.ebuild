# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-timezone/eselect-timezone-0.2.ebuild,v 1.1 2012/11/17 02:16:29 ottxor Exp $

EAPI=4

DESCRIPTION="Manages timezone selection"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~ottxor/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	insinto /usr/share/eselect/modules
	doins timezone.eselect
}
