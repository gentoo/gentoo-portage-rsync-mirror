# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/speex/speex-1.2_rc1.ebuild,v 1.13 2015/01/29 18:00:48 mgorny Exp $

EAPI=2
inherit autotools eutils flag-o-matic

MY_P=${P/_} ; MY_P=${MY_P/_p/.}

DESCRIPTION="Audio compression format designed for speech"
HOMEPAGE="http://www.speex.org"
SRC_URI="http://downloads.xiph.org/releases/speex/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="ogg cpu_flags_x86_sse static-libs"

RDEPEND="ogg? ( media-libs/libogg )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch

	sed -i \
		-e 's:noinst_PROGRAMS:check_PROGRAMS:' \
		libspeex/Makefile.am || die

	eautoreconf
}

src_configure() {
	append-lfs-flags

	econf \
		$(use_enable static-libs static) \
		--disable-dependency-tracking \
		$(use_enable cpu_flags_x86_sse sse) \
		$(use_enable ogg)
}

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install || die
	dodoc AUTHORS ChangeLog NEWS README* TODO

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
