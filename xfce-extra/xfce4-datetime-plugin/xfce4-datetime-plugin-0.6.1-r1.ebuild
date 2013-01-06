# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-datetime-plugin/xfce4-datetime-plugin-0.6.1-r1.ebuild,v 1.1 2012/12/17 23:09:57 ssuominen Exp $

EAPI=5
EAUTORECONF=1
inherit xfconf

DESCRIPTION="A panel plug-in with date, time and embedded calender"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-datetime-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.24:2
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10
	>=xfce-base/xfce4-panel-4.10"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-port-to-libxfce4ui.patch )

	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS THANKS )
}

src_prepare() {
	# http://bugzilla.xfce.org/show_bug.cgi?id=9654
	sed -i -e '/Encoding/d' panel-plugin/datetime.desktop.in.in || die

	# http://bugzilla.xfce.org/show_bug.cgi?id=8064#c2
	sed -i -e 's:BM_DEBUG_SUPPORT:XDT_FEATURE_DEBUG:' configure.in || die

	xfconf_src_prepare
}
