# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/harfbuzz/harfbuzz-0.9.18-r1.ebuild,v 1.1 2013/06/06 05:23:28 tetromino Exp $

EAPI=5

EGIT_REPO_URI="git://anongit.freedesktop.org/harfbuzz"
[[ ${PV} == 9999 ]] && inherit git-2 autotools

inherit eutils libtool autotools

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/HarfBuzz"
[[ ${PV} == 9999 ]] || SRC_URI="http://www.freedesktop.org/software/${PN}/release/${P}.tar.bz2"

LICENSE="Old-MIT ISC icu"
SLOT="0/0.9.18" # 0.9.18 introduced the harfbuzz-icu split; bug #472416
[[ ${PV} == 9999 ]] || \
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~x86-macos ~x64-macos ~x64-solaris"
IUSE="+cairo +glib +graphite icu static-libs +truetype"

RDEPEND="
	cairo? ( x11-libs/cairo:= )
	glib? ( dev-libs/glib:2 )
	graphite? ( media-gfx/graphite2:= )
	icu? ( dev-libs/icu:= )
	truetype? ( media-libs/freetype:2= )
"
DEPEND="${RDEPEND}
	dev-util/ragel
	virtual/pkgconfig
"

src_prepare() {
	if [[ ${CHOST} == *-darwin* ]] ; then
		# on Darwin we need to link with g++, like automake defaults to,
		# but overridden by upstream because on Linux this is not
		# necessary, bug #449126
		sed -i \
			-e 's/\<LINK\>/CXXLINK/' \
			src/Makefile.am || die
		sed -i \
			-e '/libharfbuzz_la_LINK = /s/\<LINK\>/CXXLINK/' \
			src/Makefile.in || die
	fi

	[[ ${PV} == 9999 ]] && eautoreconf
	elibtoolize  # for building a shared library on x64-solaris

	epatch "${FILESDIR}/${P}-ldadd.patch"
	eautoreconf
}

src_configure() {
	econf \
		--without-coretext \
		--without-uniscribe \
		$(use_enable static-libs static) \
		$(use_with cairo) \
		$(use_with glib) \
		$(use_with graphite graphite2) \
		$(use_with icu) \
		$(use_with truetype freetype)

}

src_install() {
	default
	prune_libtool_files --modules
}
