# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wm2/wm2-4-r1.ebuild,v 1.3 2011/12/18 19:46:08 phajdan.jr Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Small, unconfigurable window manager"
HOMEPAGE="http://www.all-day-breakfast.com/wm2/"
SRC_URI="http://www.all-day-breakfast.com/wm2/${P}.tar.gz"

RDEPEND="x11-libs/libXmu"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

SLOT="0"
LICENSE="freedist"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -e "s/CFLAGS/CXXFLAGS/" \
		-e "s/\$(CCC) -o/\$(CCC) \$(LDFLAGS) -o/" \
		-i Makefile || die #334681

	sed 's/^#//' Config.h > wm2.conf
	if [ -e "/etc/wm2.conf" ]; then
		echo "#undef _CONFIG_H_" >> Config.h
		awk '/^[^/]/{print "#" $0}' /etc/wm2.conf >> Config.h
	fi
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" CCC="$(tc-getCXX)" \
		LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin wm2 || die
	insinto /etc
	doins wm2.conf || die
	dodoc README || die
}

pkg_postinst() {
	echo
	elog "wm2 is unconfigurable after you have installed. If you want to"
	elog "change settings of wm2, please have a look at /etc/wm2.conf"
	elog "and rewrite it, then emerge wm2 again (wm2 ebuild uses settings"
	elog "from that file automatically). If you think wm2 lacks some important"
	elog "features that you want to use (such as background pixmaps),"
	elog "consider using wmx, written by the same author."
	echo
}
