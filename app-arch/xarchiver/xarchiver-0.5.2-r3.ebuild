# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xarchiver/xarchiver-0.5.2-r3.ebuild,v 1.7 2012/11/28 12:32:35 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="a GTK+ based and advanced archive manager that can be used with Thunar"
HOMEPAGE="http://xarchiver.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.10:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-stack-smash.patch
		"${FILESDIR}"/${P}-add_xz_support.patch
		"${FILESDIR}"/${P}-drag-n-drop_escaped_path.patch
		)

	XFCONF=(
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_prepare() {
	sed -i -e '/COPYING/d' doc/Makefile.in || die
	xfconf_src_prepare
}

src_install() {
	xfconf_src_install DOCDIR="${ED}/usr/share/doc/${PF}"
}

pkg_postinst() {
	xfconf_pkg_postinst
	elog "You need external programs for some formats, including"
	elog "7zip - app-arch/p7zip"
	elog "arj - app-arch/unarj app-arch/arj"
	elog "lha - app-arch/lha"
	elog "lzop - app-arch/lzop"
	elog "rar - app-arch/unrar app-arch/rar"
	elog "zip - app-arch/unzip app-arch/zip"
}
