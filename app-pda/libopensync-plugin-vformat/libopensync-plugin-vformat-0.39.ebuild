# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-vformat/libopensync-plugin-vformat-0.39.ebuild,v 1.4 2012/05/03 20:20:58 jdhore Exp $

EAPI="3"

inherit cmake-utils

DESCRIPTION="OpenSync VFormat Plugin"
HOMEPAGE="http://www.opensync.org"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="~app-pda/libopensync-${PV}
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# Don't pass
RESTRICT="test"

DOCS="AUTHORS ChangeLog"
