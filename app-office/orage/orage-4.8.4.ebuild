# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/orage/orage-4.8.4.ebuild,v 1.5 2013/04/11 18:08:41 ago Exp $

EAPI=5
inherit multilib xfconf

DESCRIPTION="A time managing application (and panel plug-in) for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2
	http://dev.gentoo.org/~ssuominen/${P}-nn.po.xz
	http://dev.gentoo.org/~ssuominen/${P}-sr.po.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="berkdb dbus debug libnotify +xfce_plugins_clock"

RDEPEND=">=dev-libs/libical-0.48:=
	dev-libs/popt:=
	>=x11-libs/gtk+-2.10:2
	berkdb? ( >=sys-libs/db-4 )
	dbus? ( >=dev-libs/dbus-glib-0.100 )
	libnotify? ( >=x11-libs/libnotify-0.7:= )
	xfce_plugins_clock? ( >=xfce-base/xfce4-panel-4.10 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		--docdir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable xfce_plugins_clock libxfce4panel)
		$(use_enable dbus)
		$(use_enable libnotify)
		$(use_with berkdb bdb4)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )

	# PM doesn't let directory to be replaced by a symlink, see src_install()
	rm -rf "${EROOT}"/usr/share/${PN}/doc
}

src_prepare() {
	# http://bugzilla.xfce.org/show_bug.cgi?id=9990
	local lang
	for lang in nn sr; do
		mv "${WORKDIR}"/${P}-${lang}.po po/${lang}.po || die
	done
	xfconf_src_prepare
}

src_install() {
	xfconf_src_install \
		docdir="${EPREFIX}"/usr/share/doc/${PF}/html \
		imagesdir="${EPREFIX}"/usr/share/doc/${PF}/html/images

	# Create compability symlink for retarded path hardcoding in src/{mainbox,parameters}.c
	dosym /usr/share/doc/${PF}/html /usr/share/${PN}/doc/C
}
