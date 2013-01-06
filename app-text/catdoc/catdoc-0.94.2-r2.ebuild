# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/catdoc/catdoc-0.94.2-r2.ebuild,v 1.3 2010/09/15 11:22:35 grobian Exp $

EAPI=3
WANT_AUTOMAKE=none

inherit autotools eutils

DESCRIPTION="Converter for Microsoft Word, Excel, PowerPoint and RTF files to text"
HOMEPAGE="http://www.wagner.pp.ru/~vitus/software/catdoc/"
SRC_URI="http://ftp.wagner.pp.ru/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="tk"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"

DEPEND="tk? ( >=dev-lang/tk-8.1 )"

DOCS="CODING.STD CREDITS NEWS README TODO"

src_prepare() {
	epatch "${FILESDIR}/${P}-flags.patch"
	epatch "${FILESDIR}/${P}+autoconf-2.63.patch"

	# Fix for case-insensitive filesystems
	echo ".PHONY: all install clean distclean dist" >> Makefile.in

	eautoconf
}

src_configure() {
	econf --with-install-root="${D}" \
		$(use_with tk wish "${EPREFIX}"/usr/bin/wish) \
		$(use_enable tk wordview)
}

src_compile() {
	emake LIB_DIR="${EPREFIX}"/usr/share/catdoc || die
}

src_install() {
	emake -j1 mandir="${EPREFIX}"/usr/share/man/man1 install || die

	if [[ -e ${ED}/usr/bin/xls2csv ]]; then
		einfo "Renaming xls2csv to xls2csv-${PN} because of bug 314657."
		mv -vf "${ED}"/usr/bin/xls2csv "${ED}"/usr/bin/xls2csv-${PN} || die
	fi

	dodoc ${DOCS}
}
