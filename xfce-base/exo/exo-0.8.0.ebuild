# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/exo/exo-0.8.0.ebuild,v 1.11 2012/11/28 12:27:20 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="Extensions, widgets and framework library with session support for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-lang/perl-5.6
	>=dev-libs/glib-2.24
	dev-perl/URI
	>=x11-libs/gtk+-2.20:2
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	[[ ${CHOST} == *-darwin* ]] && XFCONF+=( --disable-visibility ) #366857

	DOCS=( AUTHORS ChangeLog HACKING NEWS README THANKS TODO )
}
