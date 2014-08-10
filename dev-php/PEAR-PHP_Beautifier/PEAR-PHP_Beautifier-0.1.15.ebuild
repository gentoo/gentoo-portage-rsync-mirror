# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_Beautifier/PEAR-PHP_Beautifier-0.1.15.ebuild,v 1.2 2014/08/10 20:54:19 slyfox Exp $

EAPI="2"
inherit php-pear-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Code Beautifier for PHP"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[tokenizer]"
RDEPEND="$DEPEND >=dev-php/PEAR-Log-1.8"

pkg_postinst() {
	if ! has_version dev-lang/php[bzip2] ; then
		elog "${PN} can optionally use bzip2 features."
		elog "If you want those, emerge dev-lang/php with this flag in USE."
	fi
}
