# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/xdsi/xdsi-0.92-r1.ebuild,v 1.1 2012/01/31 08:30:01 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="A crude interface for running the XDS"
HOMEPAGE="http://strucbio.biologie.uni-konstanz.de/xdswiki/index.php/Xdsi/"
SRC_URI="ftp://turn5.biologie.uni-konstanz.de/pub/${PN}_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	app-text/mupdf
	dev-lang/tk
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	sci-chemistry/mosflm
	sci-chemistry/pointless
	sci-chemistry/xds-bin[smp]
	sci-visualization/gnuplot
	sci-visualization/xds-viewer"
# Need to clarified for licensing
# sci-chemistry/xdsstat-bin
DEPEND=""

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	sed \
		-e "s:GENTOOTEMPLATE:${EPREFIX}/usr/share/${PN}/templates:g" \
		-e "s:kpdf:mupdf:g" \
		-e "s:xds-viewer-0.6:xds-viewer:g" \
		-i ${PN} || die
}

src_install() {
	dobin ${PN}
	insinto /usr/share/${PN}/templates
	doins templates/{*.INP,bohr*,fortran,pauli,info.png,*.pck,tablesf_xdsi}
	dodoc templates/*.pdf
}

pkg_postinst() {
	elog "Documentation can be found here:"
	elog "ftp://turn14.biologie.uni-konstanz.de/pub/xdsi/xdsi_doc_print.pdf"
}
