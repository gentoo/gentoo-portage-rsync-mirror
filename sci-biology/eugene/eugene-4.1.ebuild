# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/eugene/eugene-4.1.ebuild,v 1.1 2013/03/09 19:24:45 jlec Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="Eukaryotic gene predictor"
HOMEPAGE="http://www.inra.fr/mia/T/EuGene/"
SRC_URI="https://mulcyber.toulouse.inra.fr/frs/download.php/1157/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/gd[png]
	media-libs/libpng
	doc? ( dev-lang/tcl
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-latexextra
		)"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	# https://mulcyber.toulouse.inra.fr/tracker/index.php?func=detail&aid=1170
	epatch \
		"${FILESDIR}"/${PN}-3.6-overflow.patch \
		"${FILESDIR}"/${PN}-3.6-plugins.patch
	if ( ! use doc ); then
		sed -i -e '/SUBDIRS/ s/doc//' \
			-e '/INSTALL.*doc/ s/\(.*\)//' \
			Makefile.am || die
		eautoreconf
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
}
