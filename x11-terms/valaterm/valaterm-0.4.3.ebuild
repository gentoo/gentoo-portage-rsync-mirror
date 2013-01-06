# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/valaterm/valaterm-0.4.3.ebuild,v 1.3 2012/06/22 08:40:07 ssuominen Exp $

EAPI=4
inherit waf-utils

PN_vala_version=0.14

DESCRIPTION="A vala based lightweight terminal"
HOMEPAGE="http://gitorious.org/valaterm"
SRC_URI="http://gitorious.org/${PN}/${PN}/archive-tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2
	x11-libs/gtk+:3
	x11-libs/vte:2.90"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.13.2:${PN_vala_version}
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

S=${WORKDIR}/${PN}-${PN}

src_prepare() {
	sed -i \
		-e '/conf.env.CFLAGS.extend.*O/d' \
		-e '/conf.env.LINKFLAGS.extend.*O/d' \
		wscript || die
}

src_configure() {
	export VALAC="$(type -P valac-${PN_vala_version})"
	local myconf
	use nls || myconf="--disable-nls"
	waf-utils_src_configure --with-gtk3 ${myconf}
}
