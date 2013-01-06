# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/caps/caps-20071115.ebuild,v 1.5 2010/01/06 13:01:28 josejx Exp $

inherit eutils multilib

DESCRIPTION="Support library that allows third party applications access and use C.A.P.S. images"
HOMEPAGE="http://www.softpres.org/"
SRC_URI="mirror://gentoo/ipfdevlib_linux-20060612.tgz
	amd64? ( mirror://gentoo/ipflib_linux-amd64-${PV}.tgz )
	doc? ( mirror://gentoo/ipfdoc102a.zip )
	mirror://gentoo/config_uae_ocs13_512c-512s.zip"

LICENSE="CAPS"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"
RESTRICT="strip"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_install() {
	insinto /usr/include/caps
	doins ipfdevlib_linux/include/caps/capsimage.h || die

	case ${ARCH} in
		ppc)
			dolib.so ipfdevlib_linux/lib/ppc/libcapsimage.so.2.0 || die
			dobin ipfdevlib_linux/examples/ppc/ipfinfo || die
			;;
		x86)
			dolib.so ipfdevlib_linux/lib/i686/libcapsimage.so.2.0 || die
			dobin ipfdevlib_linux/examples/i686/ipfinfo || die
			;;
		amd64)
			dolib.so ipflib_linux-amd64/libcapsimage.so.2.3 || die
			dobin ipflib_linux-amd64/ipfinfo || die
			;;
		*)
			eerror "Unsupported platform"
			;;
	esac

	case ${ARCH} in
		ppc|x86)
			dosym libcapsimage.so.2.0 \
				/usr/$(get_libdir)/libcapsimage.so.2
			dodoc ipfdevlib_linux/{HISTORY,README}
			;;
		amd64)
			dosym libcapsimage.so.2.3 \
				/usr/$(get_libdir)/libcapsimage.so.2
			dodoc ipflib_linux-amd64/{HISTORY,README}
			;;
	esac

	insinto /usr/share/${PN}
	doins OCS_13_1Mb_800_600.uae || die
	doins ipfdevlib_linux/examples/ipfinfo.c || die

	use doc && dodoc CAPSLib102a-40.pdf
}
