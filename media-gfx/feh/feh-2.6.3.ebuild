# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-2.6.3.ebuild,v 1.2 2012/12/23 11:03:19 ulm Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="http://feh.finalrewind.org/"
SRC_URI="http://feh.finalrewind.org/${P}.tar.bz2"

LICENSE="feh"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="debug curl exif test xinerama"

COMMON_DEPEND=">=media-libs/giblib-1.2.4
	media-libs/imlib2
	>=media-libs/libpng-1.2:0
	x11-libs/libX11
	curl? ( net-misc/curl )
	exif? ( media-libs/libexif )
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${COMMON_DEPEND}
	virtual/jpeg"
DEPEND="${COMMON_DEPEND}
	x11-libs/libXt
	x11-proto/xproto
	test? (
		>=dev-lang/perl-5.10
		dev-perl/Test-Command
		)"

# requires the mandoc utility which we don't have at the moment
RESTRICT="test"

pkg_setup() {
	use_feh() { usex $1 1 0; }

	fehopts=(
		DESTDIR="${D}"
		PREFIX=/usr
		doc_dir='${main_dir}'/share/doc/${PF}
		example_dir='${main_dir}'/share/doc/${PF}/examples
		curl=$(use_feh curl)
		debug=$(use_feh debug)
		xinerama=$(use_feh xinerama)
		exif=$(use_feh exif)
		)
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.6.2-debug-cflags.patch
}

src_compile() {
	tc-export CC
	emake "${fehopts[@]}"
}

src_install() {
	emake "${fehopts[@]}" install
}
