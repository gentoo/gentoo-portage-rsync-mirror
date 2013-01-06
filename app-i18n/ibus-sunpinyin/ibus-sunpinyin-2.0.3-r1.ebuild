# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-sunpinyin/ibus-sunpinyin-2.0.3-r1.ebuild,v 1.2 2011/04/17 09:11:23 qiaomuf Exp $

EAPI="1"
PYTHON_DEPEND="2:2.5"
inherit eutils python scons-utils

DESCRIPTION="The SunPinYin IMEngine for IBus Framework"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-i18n/ibus
		app-i18n/sunpinyin"
DEPEND="${RDEPEND}
		sys-devel/gettext"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}" && epatch "${FILESDIR}/${P}-force-switch.patch"
}

src_compile() {
	escons --prefix="/usr" || die
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install || die
}
