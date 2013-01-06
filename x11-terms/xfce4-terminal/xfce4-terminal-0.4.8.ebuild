# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xfce4-terminal/xfce4-terminal-0.4.8.ebuild,v 1.1 2012/12/28 03:24:28 ssuominen Exp $

EAPI=5
MY_P=Terminal-${PV}
inherit xfconf

DESCRIPTION="A terminal emulator for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/terminal/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris"
IUSE="dbus debug"

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.14:2
	x11-libs/libX11
	>=x11-libs/vte-0.22.5:0
	>=xfce-base/exo-0.6
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	!gnustep-apps/terminal" #376257
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable dbus)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog HACKING NEWS README THANKS )
}
