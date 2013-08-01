# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r10.ebuild,v 1.2 2013/08/01 15:47:03 aballier Exp $

EAPI=5

# this ebuild is only for the libjpeg.so.62 SONAME for ABI compat

PATCH_VER=1
inherit eutils libtool toolchain-funcs multilib-minimal

DESCRIPTION="library to load, handle and manipulate images in the JPEG format (transition package)"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="mirror://gentoo/jpegsrc.v${PV}.tar.gz
	http://dev.gentoo.org/~ssuominen/${P}-patchset-${PATCH_VER}.tar.xz"

LICENSE="IJG"
SLOT="62"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
RDEPEND="abi_x86_32? ( !<=app-emulation/emul-linux-x86-baselibs-20130224-r4
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)] )"

DOCS=""

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	elibtoolize
}

multilib_src_configure() {
	tc-export CC
	ECONF_SOURCE=${S} \
	econf \
		--enable-shared \
		--disable-static \
		--enable-maxmem=64
}

multilib_src_compile() {
	emake libjpeg.la
}

multilib_src_install() {
	newlib.so .libs/libjpeg.so.62.0.0 libjpeg.so.62
}
