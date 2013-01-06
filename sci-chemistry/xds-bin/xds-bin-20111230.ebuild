# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/xds-bin/xds-bin-20111230.ebuild,v 1.2 2012/07/25 12:47:09 jlec Exp $

EAPI="2"

inherit eutils

DESCRIPTION="X-ray Detector Software for processing single-crystal monochromatic diffraction data."
HOMEPAGE="http://xds.mpimf-heidelberg.mpg.de/"
SRC_URI="
	x86? ( ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-IA32_Linux_x86.tar.gz -> XDS-IA32_Linux_x86-${PV}.tar.gz )
	amd64? ( ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-INTEL64_Linux_x86_64.tar.gz -> XDS-INTEL64_Linux_x86_64-${PV}.tar.gz )
	ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS_html_doc.tar.gz -> XDS_html_doc-${PV}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="smp X"

RDEPEND="X? ( sci-visualization/xds-viewer )"
DEPEND=""

QA_PREBUILT="opt/xds-bin/*"

src_unpack() {
	unpack ${A}
	mv XDS-* "${S}"
}

src_install() {
	exeinto /opt/${PN}
	doexe * || die
	if use smp; then
		rm "${D}"/opt/${PN}/{xds,mintegrate,mcolspot,xscale}
		dosym xds_par /opt/${PN}/xds || die
		dosym xscale_par /opt/${PN}/xscale || die
		dosym mintegrate_par /opt/${PN}/mintegrate || die
		dosym mcolspot_par /opt/${PN}/mcolspot || die
	else
		rm "${D}"/opt/${PN}/*par
	fi
	dohtml -r "${WORKDIR}"/XDS_html_doc/* || die
	insinto /usr/share/${PN}/INPUT_templates
	doins "${WORKDIR}"/XDS_html_doc/html_doc/INPUT_templates/* || die

	cat >> "${T}"/20xds <<- EOF
	PATH="/opt/${PN}/"
	EOF
	doenvd "${T}"/20xds || die
}

pkg_postinst() {
	elog "This package will expire on December 31, 2011"
}
