# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_Shell/PEAR-PHP_Shell-0.3.1-r1.ebuild,v 1.1 2010/06/17 13:09:20 mabi Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="A shell for PHP with history and tab-completion"
HOMEPAGE="http://jan.kneschke.de/projects/php-shell/"
SRC_URI="http://jan.kneschke.de/assets/2007/2/17/${PEAR_PN}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="auto-completion"

DEPEND="|| ( <dev-lang/php-5.3[pcre,spl,tokenizer] >=dev-lang/php-5.3[tokenizer] )
	auto-completion? ( dev-lang/php[readline] )"

src_install() {
	php-pear-r1_src_install
	dosym /usr/bin/php-shell.sh /usr/bin/php-shell
}
