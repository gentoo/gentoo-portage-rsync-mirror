# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-quicklauncher-plugin/xfce4-quicklauncher-plugin-1.9.4-r1.ebuild,v 1.16 2012/11/28 12:22:24 ssuominen Exp $

EAPI=5
#EAUTORECONF=yes
inherit autotools xfconf

DESCRIPTION="A quicklauncher plug-in for the Xfce panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-quicklauncher-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=xfce-base/xfce4-panel-4.8
	>=xfce-base/libxfcegui4-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	>=dev-util/xfce4-dev-tools-4.8
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-X-XFCE-Module-Path.patch )

	XFCONF=(
		$(use_enable debug)
		)

	DOCS=( AUTHORS ChangeLog TODO )
}

src_prepare() {
	sed -i \
		-e "/^AC_INIT/s/quicklauncher_version()/quicklauncher_version/" \
		configure.ac || die

	# Prevent glib-gettextize from running wrt #423115
	export AT_M4DIR=${EPREFIX}/usr/share/xfce4/dev-tools/m4macros
	intltoolize --automake --copy --force
	_elibtoolize --copy --force --install
	eaclocal
	eautoconf
	eautoheader
	eautomake

	xfconf_src_prepare
}
