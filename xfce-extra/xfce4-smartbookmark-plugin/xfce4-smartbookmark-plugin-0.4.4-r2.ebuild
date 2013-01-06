# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-smartbookmark-plugin/xfce4-smartbookmark-plugin-0.4.4-r2.ebuild,v 1.8 2012/11/28 12:19:21 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="Smart bookmark plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-smartbookmark-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

COMMON_DEPEND="x11-libs/gtk+:2
	x11-libs/libX11
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
RDEPEND="${COMMON_DEPEND}
	>=xfce-base/exo-0.6"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-exo-open_and_argument_handling.patch
		)

	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README )
}
src_prepare() {
	sed -i -e 's:bugs.debian:bugs.gentoo:' src/smartbookmark.c || die
	xfconf_src_prepare
}
