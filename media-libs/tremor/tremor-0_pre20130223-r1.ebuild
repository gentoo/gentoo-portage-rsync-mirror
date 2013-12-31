# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tremor/tremor-0_pre20130223-r1.ebuild,v 1.1 2013/12/29 15:59:35 aballier Exp $

EAPI=5

# svn export http://svn.xiph.org/trunk/Tremor tremor-${PV}

inherit autotools eutils multilib-minimal

DESCRIPTION="A fixed-point version of the Ogg Vorbis decoder (also known as libvorbisidec)"
HOMEPAGE="http://wiki.xiph.org/Tremor"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE="low-accuracy static-libs"

RDEPEND="media-libs/libogg:=[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( "CHANGELOG" "README" )

src_prepare() {
	sed -i \
		-e '/CFLAGS/s:-O2::' \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' \
		configure.in || die

	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable low-accuracy)
}

multilib_src_install_all() {
	einstalldocs
	dohtml -r doc/*
	prune_libtool_files
}
