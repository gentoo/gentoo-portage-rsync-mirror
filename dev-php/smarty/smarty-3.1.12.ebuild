# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-3.1.12.ebuild,v 1.10 2014/01/08 17:32:09 mabi Exp $

EAPI=4

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

MY_P="Smarty-${PV}"
DOC_PV="3.1.8"

DESCRIPTION="A template engine for PHP."
HOMEPAGE="http://www.smarty.net/"
SRC_URI="http://www.smarty.net/files/${MY_P}.tar.gz
	doc? ( http://www.smarty.net/files/docs/manual-en-${DOC_PV}.zip )"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( app-arch/unzip )"
RDEPEND="dev-lang/php"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto "/usr/share/php/${PN}"
	doins -r libs/*

	dodoc *.txt README
	use doc && dohtml -r "${WORKDIR}/manual-en/"*
}

pkg_postinst() {
	elog "${PN} has been installed in /usr/share/php/${PN}/."
	elog "To use it in your scripts, either"
	elog "1. define('SMARTY_DIR', \"/usr/share/php/${PN}/\") in your scripts, or"
	elog "2. add '/usr/share/php/${PN}/' to the 'include_path' variable in your"
	elog "php.ini file under /etc/php/SAPI (where SAPI is e.g apache2-php5.3,"
	elog "cgi-php5.3, etc)."
}
