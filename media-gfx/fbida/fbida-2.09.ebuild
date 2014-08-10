# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbida/fbida-2.09.ebuild,v 1.15 2014/08/10 21:14:20 slyfox Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="Image viewers for the framebuffer console (fbi) and X11 (ida)"
HOMEPAGE="http://www.kraxel.org/blog/linux/fbida/"
SRC_URI="http://www.kraxel.org/releases/${PN}/${P}.tar.gz
	mirror://gentoo/ida.png.bz2" #370901
LICENSE="GPL-2 IJG"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 sh sparc x86"
IUSE="curl fbcon gif imagemagick lirc pdf png scanner tiff X"

RDEPEND="
	curl? ( net-misc/curl )
	gif? ( media-libs/giflib )
	lirc? ( app-misc/lirc )
	pdf? ( app-text/ghostscript-gpl media-libs/tiff )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	imagemagick? (
		|| (
			media-gfx/imagemagick
			media-gfx/graphicsmagick[imagemagick]
		)
	)
	scanner? ( media-gfx/sane-backends )
	X? (
		>=x11-libs/motif-2.3:0
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXt
	)
	!media-gfx/fbi
	>=media-libs/fontconfig-2.2
	>=media-libs/freetype-2.0
	media-libs/libexif
	virtual/jpeg
	virtual/ttf-fonts
"

DEPEND="
	${RDEPEND}
	X? ( x11-proto/xextproto x11-proto/xproto )
"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -e 's:DGifOpenFileName,ungif:DGifOpenFileName,gif:' \
		-e 's:-lungif:-lgif:' -i "${S}/GNUmakefile"

	if [[ $(gcc-major-version) -lt 4 ]]; then
		sed	-e 's:-Wno-pointer-sign::' -i "${S}/GNUmakefile" || die
	fi

	epatch "${FILESDIR}"/ida-desktop.patch
	epatch "${FILESDIR}"/${PN}-2.08-posix-make.patch
}

src_configure() {
	# Let autoconf do its job and then fix things to build fbida
	# according to our specifications
	emake Make.config

	set_feat() {
		local useflag=${1}
		local config=${2}

		local option="yes"
		if ! use ${useflag}; then
			option="no"
		fi

		sed -i \
			-e "s|${config}.*|${config} := ${option}|" \
			"${S}/Make.config" || die
	}

	set_feat fbcon 	HAVE_LINUX_FB_H
	set_feat X 		HAVE_MOTIF
	set_feat tiff 	HAVE_LIBTIFF

	# The 'pdf' flag forces the use of libtiff.
	set_feat pdf	HAVE_LIBTIFF
	set_feat png 	HAVE_LIBPNG
	set_feat gif 	HAVE_LIBUNGIF
	set_feat lirc 	HAVE_LIBLIRC
	set_feat curl 	HAVE_LIBCURL
	set_feat scanner HAVE_LIBSANE
	set_feat imagemagick HAVE_LIBMAGICK
}

src_compile() {
	emake verbose=yes
}

src_install() {
	emake \
		DESTDIR="${D}" \
		STRIP="" \
		prefix=/usr \
		install

	dodoc README

	if ! use pdf; then
		rm -f "${D}"/usr/bin/fbgs "${D}"/usr/share/man/man1/fbgs.1
	fi

	if use X ; then
		doicon "${WORKDIR}"/ida.png
		domenu desktop/ida.desktop
	fi
}
