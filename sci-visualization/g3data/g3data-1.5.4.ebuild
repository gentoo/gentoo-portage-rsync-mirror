# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/g3data/g3data-1.5.4.ebuild,v 1.1 2012/08/06 23:57:35 bicatali Exp $

EAPI=4
inherit autotools-utils eutils

DESCRIPTION="Tool for extracting data from graphs"
HOMEPAGE="http://www.frantz.fi/software/g3data.php"
SRC_URI="https://github.com/downloads/pn2200/g3data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
