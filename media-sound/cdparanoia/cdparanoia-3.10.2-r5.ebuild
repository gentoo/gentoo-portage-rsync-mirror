# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.10.2-r5.ebuild,v 1.1 2013/01/15 20:55:02 ssuominen Exp $

EAPI=5
inherit autotools eutils flag-o-matic libtool toolchain-funcs versionator

MY_P=${PN}-III-$(get_version_component_range 2-3)
DESCRIPTION="an advanced CDDA reader with error correction"
HOMEPAGE="http://www.xiph.org/paranoia"
SRC_URI="http://downloads.xiph.org/releases/${PN}/${MY_P}.src.tgz
	http://dev.gentoo.org/~ssuominen/${MY_P}-patches-2.tbz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND="app-admin/eselect-cdparanoia"
DEPEND=${RDEPEND}

S=${WORKDIR}/${MY_P}

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patches

	mv configure.guess config.guess
	mv configure.sub config.sub

	sed -i -e '/configure.\(guess\|sub\)/d' configure.in || die

	eautoconf
	elibtoolize
}

src_configure() {
	tc-export AR CC RANLIB
	append-flags -I"${S}/interface"
	econf
}

src_compile() {
	emake OPT="${CFLAGS}"
	use static-libs && emake lib OPT="${CFLAGS}"
}

src_install() {
	default
	mv "${ED}"/usr/bin/${PN}{,-paranoia}
}

pkg_postinst() {
	eselect ${PN} update ifunset
}

pkg_postrm() {
	eselect ${PN} update ifunset
}
