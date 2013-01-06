# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/pyxplot/pyxplot-0.8.4.ebuild,v 1.5 2012/08/06 09:05:18 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit multilib python

DESCRIPTION="Gnuplot like graphing program publication-quality figures"
HOMEPAGE="http://www.pyxplot.org.uk/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-text/gv
	dev-libs/libxml2:2
	media-libs/libpng
	sci-libs/cfitsio
	sci-libs/fftw:3.0
	sci-libs/gsl
	sci-libs/scipy
	virtual/latex-base
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed \
		-e 's:/local:/:' \
		-e "s:/lib/:/$(get_libdir)/:" \
		-e "s:\${USRDIR}/share/${PN}:/$(python_get_sitedir)/${PN}:" \
		-e "s:/doc/${PN}:/doc/${PF}:" \
		-i Makefile.skel || die "sed Makefile.skel failed"
	sed -i -e 's/-ltermcap//' configure || die
}
