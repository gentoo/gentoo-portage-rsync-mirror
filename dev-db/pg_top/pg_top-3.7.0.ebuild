# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pg_top/pg_top-3.7.0.ebuild,v 1.2 2014/11/03 11:25:43 titanofold Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils eutils

DESCRIPTION="'top' for PostgreSQL"
HOMEPAGE="http://ptop.projects.postgresql.org/"
SRC_URI="http://pgfoundry.org/frs/download.php/3504/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="virtual/postgresql"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( FAQ HISTORY README TODO Y2K )
PATCHES=( "${FILESDIR}/${P}.patch" )

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)
	autotools-utils_src_configure
}
