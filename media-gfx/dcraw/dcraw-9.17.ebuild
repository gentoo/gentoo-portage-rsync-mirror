# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/dcraw/dcraw-9.17.ebuild,v 1.1 2013/01/24 09:57:21 xmw Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Converts the native (RAW) format of various digital cameras into netpbm portable pixmap (.ppm) image"
HOMEPAGE="http://www.cybercom.net/~dcoffin/dcraw/"
SRC_URI="http://www.cybercom.net/~dcoffin/dcraw/archive/${P}.tar.gz
	mirror://gentoo/parse-1.73.tar.bz2
	gimp? ( mirror://gentoo/rawphoto-1.32.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="nls gimp jpeg jpeg2k lcms"

COMMON_DEPEND="jpeg? ( virtual/jpeg )
	lcms? ( =media-libs/lcms-1* )
	jpeg2k? ( media-libs/jasper )
	gimp? ( media-gfx/gimp )"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )
	gimp? ( virtual/pkgconfig )"
RDEPEND="${COMMON_DEPEND}
	media-libs/netpbm"

S=${WORKDIR}/dcraw

LANGS="ca cs de da eo es fr hu it nl pl pt ru sv zh_CN zh_TW"

for lng in ${LANGS}; do
	IUSE+=" linguas_${lng}"
done

# Helper function to list only langs listed in LANGS or
linguas_list() {
	local nolangs=true
	for lng in ${LANGS}; do
		if use linguas_${lng}; then
			nolangs=false
			echo " ${lng}"
		fi
	done
	if ${nolangs}; then
		echo ${LANGS}
	fi
}

run_build() {
	einfo "${@}"
	${@} || die
}

src_prepare() {
	rename dcraw_ dcraw. dcraw_*.1 || die "Failed to rename"
}

src_compile() {
	local ECFLAGS="-O2" # Without optimisation build fails
	local ELIBS="-lm"

	use lcms && ELIBS="-llcms ${ELIBS}" || ECFLAGS+=" -DNO_LCMS=yes"
	use jpeg && ELIBS="-ljpeg ${ELIBS}" || ECFLAGS+=" -DNO_JPEG=yes"
	use jpeg2k && ELIBS="-ljasper ${ELIBS}" || ECFLAGS+=" -DNO_JASPER=yes"
	use nls && ECFLAGS+=" -DLOCALEDIR=\"/usr/share/locale/\""

	run_build $(tc-getCC) ${ECFLAGS} ${CFLAGS} ${LDFLAGS} \
				-o dcraw dcraw.c ${ELIBS}

	run_build $(tc-getCC) -O2 ${CFLAGS} ${LDFLAGS} \
				-o dcparse parse.c

	# rawphoto gimp plugin
	if use gimp; then
		run_build $(tc-getCC) ${CFLAGS} ${LDFLAGS} \
				$(pkg-config --cflags gimpui-2.0) rawphoto.c -o rawphoto \
				$(pkg-config --libs gimpui-2.0)
	fi

	if use nls; then
		for lng in $(linguas_list); do
			run_build msgfmt -c -o dcraw_${lng}.mo dcraw_${lng}.po
		done
	fi
}

src_install() {
	dobin dcraw dcparse || die
	dodoc "${FILESDIR}"/{conversion-examples.txt,dcwrap} || die

	# rawphoto gimp plugin
	if use gimp; then
		insinto "$(pkg-config --variable=gimplibdir gimp-2.0)/plug-ins"
		insopts -m0755
		doins rawphoto || die
	fi

	doman dcraw.1 || die
	if use nls; then
		for lng in $(linguas_list); do
			[[ -f dcraw.${lng}.1 ]] && doman dcraw.${lng}.1
			insinto /usr/share/locale/${lng}/LC_MESSAGES
			newins dcraw_${lng}.mo dcraw.mo || die "failed to install dcraw_${lng}.mo"
		done
	fi
}

pkg_postinst() {
	elog ""
	elog "See conversion-examples.txt.gz on how to convert"
	elog "the PPM files produced by dcraw to other image formats."
	elog ""
	ewarn "The functionality of the external program 'fujiturn' was"
	ewarn "incorporated into dcraw and is automatically used now."
	elog ""
	elog "There's an example wrapper script included called 'dcwrap'."
	elog ""
	elog "This package also includes 'dcparse', which extracts"
	elog "thumbnail images (preferably JPEGs) from any raw digital"
	elog "camera formats that have them, and shows table contents."
	elog ""
}
