# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/twig/twig-1.0.0.ebuild,v 1.2 2011/04/16 12:32:46 olemarkus Exp $

EAPI="2"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="Twig"
inherit php-pear-lib-r1

DESCRIPTION="PHP templating engine with syntax similar to Django"
HOMEPAGE="http://www.phing.info/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	#Docs folder does not really contain anything interesting
	dodoc AUTHORS README.markdown
	rm AUTHORS README.markdown
	php-pear-lib-r1_src_install
	rm -r "${D}"/usr/share/php/docs
}
