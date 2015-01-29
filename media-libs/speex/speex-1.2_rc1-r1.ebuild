# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/speex/speex-1.2_rc1-r1.ebuild,v 1.7 2015/01/29 18:00:48 mgorny Exp $

EAPI=5
inherit autotools eutils flag-o-matic

MY_P=${P/_} ; MY_P=${MY_P/_p/.}

DESCRIPTION="Audio compression format designed for speech"
HOMEPAGE="http://www.speex.org/"
SRC_URI="http://downloads.xiph.org/releases/speex/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="ogg cpu_flags_x86_sse static-libs"

RDEPEND="ogg? ( media-libs/libogg:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PF}-configure.patch

	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die #467012

	sed -i \
		-e 's:noinst_PROGRAMS:check_PROGRAMS:' \
		libspeex/Makefile.am || die

	eautoreconf
}

src_configure() {
	append-lfs-flags

	econf \
		$(use_enable static-libs static) \
		$(use_enable cpu_flags_x86_sse sse) \
		$(use_enable ogg)
}

src_install() {
	emake DESTDIR="${D}" docdir="${EPREFIX}/usr/share/doc/${PF}" install
	dodoc AUTHORS ChangeLog NEWS README* TODO

	prune_libtool_files
}
