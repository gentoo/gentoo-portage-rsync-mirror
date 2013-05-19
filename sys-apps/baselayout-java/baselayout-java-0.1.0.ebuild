# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout-java/baselayout-java-0.1.0.ebuild,v 1.3 2013/05/19 19:18:50 aballier Exp $

EAPI=5

inherit fdo-mime gnome2-utils

DESCRIPTION="Baselayout for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="http://dev.gentoo.org/~sera/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="!<dev-java/java-config-2.2"

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
