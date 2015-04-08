# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-vala/xfce4-vala-4.10.3.ebuild,v 1.1 2013/09/03 14:30:35 ssuominen Exp $

EAPI=5
MY_VALA_VERSION=0.20
VALA_MIN_API_VERSION=${MY_VALA_VERSION}
VALA_MAX_API_VERSION=${MY_VALA_VERSION}
VALA_USE_DEPEND=vapigen
inherit xfconf vala

DESCRIPTION="Vala bindings for the Xfce desktop environment"
HOMEPAGE="http://wiki.xfce.org/vala-bindings"
SRC_URI="mirror://xfce/src/bindings/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(vala_depend)
	>=xfce-base/exo-0.10
	>=xfce-base/garcon-0.2
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10
	>=xfce-base/xfce4-panel-4.10
	>=xfce-base/xfconf-4.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog NEWS README TODO )
	XFCONF=(
		--with-vala-api=${MY_VALA_VERSION}
		)
}

src_prepare() {
	xfconf_src_prepare
	vala_src_prepare
}
