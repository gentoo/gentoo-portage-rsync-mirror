# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.10.0-r1.ebuild,v 1.11 2013/04/13 07:20:53 ago Exp $

EAPI=5
inherit xfconf

DESCRIPTION="A session manager for the Xfce desktop environment"
HOMEPAGE="http://docs.xfce.org/xfce/xfce4-session/start"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="consolekit debug gnome-keyring policykit udev +xscreensaver"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.98
	x11-apps/iceauth
	x11-libs/libSM
	>=x11-libs/libwnck-2.30:1
	x11-libs/libX11
	>=xfce-base/libxfce4util-4.10
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/xfconf-4.10
	gnome-keyring? ( >=gnome-base/libgnome-keyring-2.22 )
	!xfce-base/xfce-utils"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xrdb
	x11-misc/xdg-user-dirs
	consolekit? ( || ( sys-auth/consolekit >=sys-apps/systemd-40 ) )
	policykit? ( >=sys-auth/polkit-0.104-r1 )
	udev? ( >=sys-power/upower-0.9.15 )
	xscreensaver? ( || (
		>=x11-misc/xscreensaver-5.15
		gnome-extra/gnome-screensaver
		>=x11-misc/xlockmore-5.38
		>=x11-misc/slock-1
		) )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-multiple-interactive-session-save.patch )

	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--with-xsession-prefix="${EPREFIX}"/usr
		$(use_enable gnome-keyring libgnome-keyring)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )
}

src_install() {
	xfconf_src_install

	local sessiondir=/etc/X11/Sessions
	echo startxfce4 > "${T}"/Xfce4
	exeinto ${sessiondir}
	doexe "${T}"/Xfce4
	dosym Xfce4 ${sessiondir}/Xfce
}
