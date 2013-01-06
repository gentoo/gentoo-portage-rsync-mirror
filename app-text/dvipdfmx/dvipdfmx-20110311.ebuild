# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20110311.ebuild,v 1.14 2012/06/17 16:28:45 armin76 Exp $

EAPI=3
inherit autotools eutils texlive-common

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/${PN}/snapshot/latest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="app-text/libpaper
	>=media-libs/libpng-1.2:0
	sys-libs/zlib
	dev-libs/kpathsea
	app-text/libpaper"
RDEPEND="${DEPEND}
	virtual/tex-base
	>=app-text/poppler-0.12.3-r3
	app-text/poppler-data"

src_prepare() {
	epatch "${FILESDIR}"/20090708-fix_file_collisions.patch
	eautoreconf
}

src_install() {
	# Override dvipdfmx.cfg default installation location so that it is easy to
	# modify it and it gets config protected. Symlink it from the old location.
	emake configdatadir="${EPREFIX}/etc/texmf/dvipdfmx" DESTDIR="${D}" install || die
	dosym /etc/texmf/dvipdfmx/dvipdfmx.cfg /usr/share/texmf/dvipdfmx/dvipdfmx.cfg || die

	# Symlink poppler-data cMap, bug #201258
	dosym /usr/share/poppler/cMap /usr/share/texmf/fonts/cmap/cMap || die
	dodoc AUTHORS ChangeLog README || die

	# Remove symlink conflicting with app-text/dvipdfm (bug #295235)
	rm "${ED}"/usr/bin/ebb
}

pkg_postinst() {
	etexmf-update
}

pkg_postrm() {
	etexmf-update
}
