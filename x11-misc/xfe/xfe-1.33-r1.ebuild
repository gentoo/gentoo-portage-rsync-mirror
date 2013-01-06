# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-1.33-r1.ebuild,v 1.1 2012/12/25 22:28:55 hasufell Exp $

EAPI=5

PLOCALES="
	bs ca cs da de el es_AR es fr hu it ja nl no pl pt_BR pt_PT ru sv tr zh_CN
	zh_TW
"
inherit autotools base l10n

DESCRIPTION="MS-Explorer-like minimalist file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug nls startup-notification"

RDEPEND="
	media-libs/libpng:0
	x11-libs/fox:1.6[truetype,png]
	x11-libs/libX11
	x11-libs/libXft
	startup-notification? ( x11-libs/startup-notification )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
	)
"

DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )
PATCHES=(
	"${FILESDIR}"/${PN}-1.32.2-missing_Xlib_h.patch
	"${FILESDIR}"/${P}-flags.patch
	"${FILESDIR}"/${P}-desktopfile.patch
)

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

	# malformed LINGUAS file
	# recent intltool expects newline for every linguas
	sed -i \
		-e '/^#/!s/\s\s*/\n/g' \
		po/LINGUAS || die

	# remove not selected locales
	rm_locale() { sed -i -e "/${1}/d" po/LINGUAS || die ;}
	l10n_for_each_disabled_locale_do rm_locale

	eautoreconf
}

src_configure() {
	econf \
		--enable-minimalflags \
		$(use_enable nls) \
		$(use_enable startup-notification sn) \
		$(use_enable debug)
}
