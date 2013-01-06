# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.998.ebuild,v 1.8 2012/05/05 07:00:20 jdhore Exp $

EAPI="4"

inherit eutils

DESCRIPTION="graphical scanning frontend"
HOMEPAGE="http://www.xsane.org/"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz
	http://dev.gentoo.org/~pacho/xsane/${P}-patches.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="nls jpeg png tiff gimp lcms ocr"

RDEPEND="media-gfx/sane-backends
	x11-libs/gtk+:2
	x11-misc/xdg-utils
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	gimp? ( media-gfx/gimp )
	lcms? ( =media-libs/lcms-1* )"

PDEPEND="ocr? ( app-text/gocr )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	export OLDXSANE
	if has_version '<=media-gfx/xsane-0.93'; then
		OLDXSANE="yes"
	else
		OLDXSANE="no"
	fi
}

src_prepare() {
	# Apply multiple fixes from different distributions
	epatch "${WORKDIR}/${P}-patches"/*.patch

	# Fix compability with libpng15 wrt #377363
	sed -i -e 's:png_ptr->jmpbuf:png_jmpbuf(png_ptr):' src/xsane-save.c || die
}

src_configure() {
	local extraCPPflags
	if use lcms; then
		extraCPPflags="-I /usr/include/lcms"
	fi
	CPPFLAGS="${CPPFLAGS} ${extraCPPflags}" econf --enable-gtk2 \
		$(use_enable nls) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_enable gimp) \
		$(use_enable lcms)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc xsane.*

	# link xsane so it is seen as a plugin in gimp
	if use gimp; then
		local plugindir
		if [ -x /usr/bin/gimptool ]; then
			plugindir="$(gimptool --gimpplugindir)/plug-ins"
		elif [ -x /usr/bin/gimptool-2.0 ]; then
			plugindir="$(gimptool-2.0 --gimpplugindir)/plug-ins"
		else
			die "Can't find GIMP plugin directory."
		fi
		dodir "${plugindir}"
		dosym /usr/bin/xsane "${plugindir}"
	fi

	newicon src/xsane-48x48.png ${PN}.png
}

pkg_postinst() {
	if [ x${OLDXSANE} = 'xyes' ]; then
		ewarn "If you are upgrading from <=xsane-0.93, please make sure to"
		ewarn "remove ~/.sane/xsane/xsane.rc _before_ you start xsane for"
		ewarn "the first time."
	fi
}
