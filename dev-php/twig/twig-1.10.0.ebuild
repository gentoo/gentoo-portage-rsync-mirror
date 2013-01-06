# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/twig/twig-1.10.0.ebuild,v 1.1 2012/10/10 07:21:44 djc Exp $

EAPI=4
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="Twig"
PHP_PEAR_URI="pear.twig-project.org"
inherit php-pear-lib-r1

DESCRIPTION="PHP templating engine with syntax similar to Django"
HOMEPAGE="http://twig.sensiolabs.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	pwd
	dodoc AUTHORS README.markdown
	#rm AUTHORS README.markdown
	php-pear-lib-r1_src_install
	rm -r "${D}"/usr/share/php/docs
}
