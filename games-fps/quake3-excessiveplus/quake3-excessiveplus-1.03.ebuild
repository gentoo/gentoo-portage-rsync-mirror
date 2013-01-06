# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-excessiveplus/quake3-excessiveplus-1.03.ebuild,v 1.3 2009/10/06 23:19:50 nyhm Exp $

EAPI=2

MOD_DESC="modification making the weapons much faster and stronger"
MOD_NAME="Excessive Plus"
MOD_DIR="excessiveplus"
MOD_ICON="excessiveplus.ico"

inherit games games-mods

HOMEPAGE="http://www.excessiveplus.net/"
SRC_URI="http://www.excessiveplus.net/downloads/xp-${PV}-full.zip"

LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"

src_prepare() {
	rm -f *.bat
	rm -rf ${MOD_DIR}/tools
}
