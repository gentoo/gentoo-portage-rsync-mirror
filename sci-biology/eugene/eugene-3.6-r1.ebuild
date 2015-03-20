# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/eugene/eugene-3.6-r1.ebuild,v 1.5 2015/03/20 16:38:39 jlec Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="Eukaryotic gene predictor"
HOMEPAGE="http://www.inra.fr/mia/T/EuGene/"
# self-signed https SRC_URI
#SRC_URI="http://mulcyber.toulouse.inra.fr/gf/download/frsrelease/220/3675/${P}-1.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="doc"
KEYWORDS="amd64 x86"

RESTRICT="test"

DEPEND="media-libs/gd[png]
	media-libs/libpng:0
	doc? ( dev-lang/tcl:0
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-latexextra
		)"
RDEPEND="${DEPEND}"

src_prepare() {
	# https://mulcyber.toulouse.inra.fr/tracker/index.php?func=detail&aid=1170
	epatch "${FILESDIR}"/${P}-overflow.patch \
		"${FILESDIR}"/${P}-plugins.patch
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
