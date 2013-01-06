# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-2.30.3.ebuild,v 1.9 2012/05/05 04:10:05 jdhore Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GNOME 2 default icon themes"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	sys-devel/gettext"
# Upstream didn't give us a ChangeLog with 2.30
DOCS="AUTHORS NEWS TODO"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

# FIXME: double check potential LINGUAS problem
pkg_setup() {
	G2CONF="${G2CONF} --enable-icon-mapping"
}
