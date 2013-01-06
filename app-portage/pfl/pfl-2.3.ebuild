# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/pfl/pfl-2.3.ebuild,v 1.7 2012/03/18 15:19:04 armin76 Exp $

EAPI=4

PYTHON_DEPEND=2
PYTHON_USE_WITH=xml

inherit python

MY_PV=20110906

DESCRIPTION="PFL is an online searchable file/package database for Gentoo"
HOMEPAGE="http://www.portagefilelist.de/index.php/Special:PFLQuery2"
SRC_URI="http://files.portagefilelist.de/${P}
	http://files.portagefilelist.de/e-file-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc sparc x86"
IUSE="+network-cron"

DEPEND=""
RDEPEND="${DEPEND}
	net-misc/curl
	sys-apps/portage"

S="${WORKDIR}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	cp "${DISTDIR}/${P}" "${WORKDIR}/${PN}.py" || die
	cp "${DISTDIR}/e-file-${MY_PV}" "${WORKDIR}/e-file" || die
}

src_install() {
	local cmd="$(PYTHON) -O $(python_get_sitedir)/${PN}/${PN}.py"

	exeinto $(python_get_sitedir)/${PN}
	doexe ${PN}.py

	dobin e-file

	dodir /var/lib/${PN}

	# create wrapper script to run pfl manually
	cat > "${T}/${PN}" <<- EOF
	#!${EPREFIX}/bin/sh
	${cmd}
	EOF
	dosbin "${T}/${PN}"

	if use network-cron ; then
		# modify the wrapper script to be usable as cron job
		sed -i -e "s|${cmd}|exec nice ${cmd} >/dev/null|g" "${T}/${PN}" || die
		exeinto /etc/cron.weekly
		doexe "${T}/${PN}"
	fi
}

pkg_postinst() {
	python_mod_optimize ${PN}

	if [[ ! -e "${EROOT%/}/var/lib/${PN}/pfl.info" ]]; then
		touch "${EROOT%/}/var/lib/${PN}/pfl.info"
		chown -R 0:portage "${EROOT%/}/var/lib/${PN}"
		chmod 775 "${EROOT%/}/var/lib/${PN}"
	fi
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
