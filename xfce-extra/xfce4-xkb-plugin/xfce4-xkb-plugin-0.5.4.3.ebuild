# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb-plugin/xfce4-xkb-plugin-0.5.4.3.ebuild,v 1.6 2012/11/28 12:21:52 ssuominen Exp $

EAPI=5
inherit multilib xfconf

DESCRIPTION="XKB layout switching panel plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-xkb-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*.*}/${P}.tar.bz2"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND="x11-libs/gtk+:2
	>=x11-libs/libwnck-2.12:1
	>=x11-libs/libxklavier-5
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	>=gnome-base/librsvg-2.18
	x11-proto/kbproto"

pkg_setup() {
	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog README )
}
