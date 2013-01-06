# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-1.33.ebuild,v 1.5 2012/12/28 11:09:50 ago Exp $

EAPI=4

inherit base

DESCRIPTION="MS-Explorer-like minimalist file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="debug nls startup-notification"

XFELINGUAS="
	bs ca cs da de el es_AR es fr hu it ja nl no pl pt_BR pt_PT ru sv tr zh_CN
	zh_TW
"
for lingua in ${XFELINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

RDEPEND="
	media-libs/libpng:0
	startup-notification? ( x11-libs/startup-notification )
	x11-libs/fox:1.6[truetype,png]
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )
PATCHES=( "${FILESDIR}"/${PN}-1.32.2-missing_Xlib_h.patch )

src_prepare() {
	base_src_prepare
	cat >po/POTFILES.skip <<-EOF
	src/icons.cpp
	xfe.desktop.in.in
	xfi.desktop.in.in
	xfp.desktop.in.in
	xfv.desktop.in.in
	xfw.desktop.in.in
	EOF

	local lingua
	for lingua in ${XFELINGUAS}; do
		if ! use linguas_${lingua}; then
			sed -i po/LINGUAS -e "s|${lingua}||g" || die
		fi
	done
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable startup-notification sn) \
		$(use_enable debug)
}
