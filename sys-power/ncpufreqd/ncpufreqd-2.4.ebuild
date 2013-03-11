# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-2.4.ebuild,v 1.6 2013/03/11 19:47:09 creffett Exp $

EAPI="5"

inherit cmake-utils

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://projects.simpledesigns.com.pl/project/ncpufreqd/"
SRC_URI="http://projects.simpledesigns.com.pl/get/${P}.tar.bz2"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

DEPEND="virtual/logger"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install

	doinitd gentoo-init.d/ncpufreqd
	dodoc AUTHORS ChangeLog README
}
