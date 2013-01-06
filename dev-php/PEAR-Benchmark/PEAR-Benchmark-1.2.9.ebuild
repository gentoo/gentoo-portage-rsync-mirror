# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Benchmark/PEAR-Benchmark-1.2.9.ebuild,v 1.8 2012/04/01 18:16:49 armin76 Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Framework to benchmark PHP scripts or function calls."
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

pkg_postinst() {
	if ! has_version "dev-lang/php[bcmath]" ; then
		elog "${PN} can optionally use dev-lang/php bcmath features."
		elog "If you want those, recompile dev-lang/php with these flags in USE."
	fi
}
