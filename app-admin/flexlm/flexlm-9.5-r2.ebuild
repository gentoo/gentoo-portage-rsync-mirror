# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/flexlm/flexlm-9.5-r2.ebuild,v 1.5 2012/10/18 17:00:39 kensington Exp $

EAPI=4
inherit user

DESCRIPTION="Macrovision FLEXlm license manager and utils"
HOMEPAGE="http://www.macrovision.com/services/support/flexlm/lmgrd.shtml"
SRC_URI="doc? ( http://www.macrovision.com/services/support/flexlm/enduser.pdf )
	x86? (
		mirror://gentoo/lmgrd-x86.Z
		mirror://gentoo/lmutil-x86.Z
	)
	amd64? (
		mirror://gentoo/lmgrd-amd64.Z
		mirror://gentoo/lmutil-amd64.Z
	)"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="doc"

QA_PREBUILT="
	opt/flexlm/bin/lmgrd
	opt/flexlm/bin/lmutil"

S="${WORKDIR}"

src_prepare() {
	mv lmutil-* lmutil || die
	mv lmgrd-* lmgrd || die
}

src_install () {
	# executables
	exeinto /opt/flexlm/bin
	doexe lmgrd lmutil

	dosym lmutil /opt/flexlm/bin/lmcksum
	dosym lmutil /opt/flexlm/bin/lmdiag
	dosym lmutil /opt/flexlm/bin/lmdown
	dosym lmutil /opt/flexlm/bin/lmhostid
	dosym lmutil /opt/flexlm/bin/lmremove
	dosym lmutil /opt/flexlm/bin/lmreread
	dosym lmutil /opt/flexlm/bin/lmstat
	dosym lmutil /opt/flexlm/bin/lmver

	# documentation
	use doc && dodoc "${DISTDIR}"/enduser.pdf

	# init files
	newinitd "${FILESDIR}"/flexlm-init flexlm
	newconfd "${FILESDIR}"/flexlm-conf flexlm

	# environment
	doenvd "${FILESDIR}"/90flexlm

	# empty dir for licenses
	keepdir /etc/flexlm

	# log dir
	dodir /var/log/flexlm
}

pkg_postinst() {
	enewgroup flexlm
	enewuser flexlm -1 /bin/bash /opt/flexlm flexlm

	# See bug 383787
	chown flexlm /var/log/flexlm || eerror "'chown flexlm /var/log/flexlm' failed!"

	elog "FlexLM installed. Config is in /etc/conf.d/flexlm"
	elog "Default location for license file is /etc/flexlm/license.dat"
}
