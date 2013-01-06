# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/valaterm/valaterm-0.6.ebuild,v 1.1 2012/10/03 17:52:17 ssuominen Exp $

EAPI=4
inherit waf-utils

PN_vala_slot=0.16
PN_vala_ver=${PN_vala_slot}

DESCRIPTION="A lightweight vala based terminal"
HOMEPAGE="http://gitorious.org/valaterm"
SRC_URI="http://gitorious.org/${PN}/${PN}/archive-tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2
	x11-libs/gtk+:3
	x11-libs/vte:2.90"
DEPEND="${RDEPEND}
	>=dev-lang/vala-${PN_vala_ver}:${PN_vala_slot}
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)"

DOCS="AUTHORS ChangeLog README TODO"

S=${WORKDIR}/${PN}-${PN}

src_configure() {
	export VALAC="$(type -P valac-${PN_vala_slot})"
	local myconf
	use nls || myconf='--disable-nls'
	waf-utils_src_configure --custom-flags --verbose ${myconf}
}
