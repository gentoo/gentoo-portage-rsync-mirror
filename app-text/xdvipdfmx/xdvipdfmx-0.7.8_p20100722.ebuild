# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvipdfmx/xdvipdfmx-0.7.8_p20100722.ebuild,v 1.15 2012/05/04 03:33:12 jdhore Exp $

EAPI="3"

DESCRIPTION="Extended dvipdfmx for use with XeTeX and other unicode TeXs."
HOMEPAGE="http://scripts.sil.org/svn-view/xdvipdfmx/
	http://tug.org/texlive/"
SRC_URI="mirror://gentoo/texlive-${PV#*_p}-source.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="!<app-text/texlive-core-2010
	dev-libs/kpathsea
	sys-libs/zlib
	media-libs/freetype:2
	media-libs/fontconfig
	>=media-libs/libpng-1.2.43-r2:0
	app-text/libpaper"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${PN}

src_configure() {
	econf \
		--with-system-kpathsea \
		--with-system-zlib \
		--with-system-libpng \
		--with-system-freetype2
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README TODO BUGS AUTHORS ChangeLog ChangeLog.TL || die
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r doc || die
	fi
}
