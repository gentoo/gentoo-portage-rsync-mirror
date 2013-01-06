# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mailwatch-plugin/xfce4-mailwatch-plugin-1.1.0-r1.ebuild,v 1.6 2012/12/26 11:07:15 ssuominen Exp $

EAPI=5
EAUTORECONF=yes
inherit multilib xfconf

DESCRIPTION="An mail notification panel plug-in for the Xfce desktop environment"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfce4-mailwatch-plugin/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug ipv6 ssl"

RDEPEND=">=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10
	>=xfce-base/xfce4-panel-4.10
	ssl? (
		dev-libs/libgcrypt
		>=net-libs/gnutls-2
		)"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-no-ssl.patch
		"${FILESDIR}"/${P}-libxfce4ui.patch
		"${FILESDIR}"/${P}-link_to_libgcrypt.patch
		"${FILESDIR}"/${P}-gnutls-3.patch
		)

	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		$(use_enable ssl)
		$(use_enable ipv6)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
