# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-shares-plugin/thunar-shares-plugin-0.2.0_p20101105.ebuild,v 1.7 2012/11/28 12:22:42 ssuominen Exp $

# git clone -b thunarx-2 git://git.xfce.org/thunar-plugins/thunar-shares-plugin

EAPI=5
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-shares-plugin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.18
	>=x11-libs/gtk+-2.12:2
	>=xfce-base/thunar-1.2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
