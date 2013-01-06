# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-vcs-plugin/thunar-vcs-plugin-0.1.4.ebuild,v 1.6 2012/11/28 12:18:36 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="adds Subversion and GIT actions to the context menu of thunar"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-vcs-plugin"
SRC_URI="mirror://xfce/src/thunar-plugins/${PN}/${PV%.*}/${P}.tar.bz2
	mirror://gentoo/${P}-ru.po.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +git +subversion"

RDEPEND=">=dev-libs/glib-2.18
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/exo-0.6
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/thunar-1.2
	git? ( dev-vcs/git )
	subversion? (
		>=dev-libs/apr-0.9.7
		>=dev-vcs/subversion-1.5
		)"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		$(use_enable subversion)
		$(use_enable git)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README )
}

src_prepare() {
	mv -vf "${WORKDIR}"/${P}-ru.po po/ru.po || die
	xfconf_src_prepare
}
