# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Log/PEAR-Log-1.12.7.ebuild,v 1.8 2014/01/26 18:31:30 olemarkus Exp $

EAPI="2"
inherit php-pear-r1 depend.php eutils

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"

DESCRIPTION="The Log framework provides an abstracted logging system.@"
LICENSE="PHP-3.01"
SLOT="0"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-DB-1.7.6-r1
	dev-php/PEAR-Mail
	>=dev-php/PEAR-MDB2-2.0.0_rc1 )"

pkg_postinst() {
	has_php
	if ! use minimal && ! has_version =${PHP_PKG}[sqlite] ; then
		elog "${PN} can optionally use ${PHP_PKG} sqlite features."
		elog "If you want those, recompile ${PHP_PKG} with this flag in USE."
	fi
}
