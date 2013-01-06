# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-openid/php-openid-2.2.2.ebuild,v 1.2 2012/01/28 14:08:19 mabi Exp $

EAPI="4"
MY_P="openid-php-openid-2.2.2-0-ga287b2d"
MY_P2="openid-php-openid-782224d"

PHP_LIB_NAME="Auth"
DESCRIPTION="PHP OpenID implementation"
HOMEPAGE="http://github.com/openid/php-openid"
SRC_URI="http://download.github.com/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="|| ( dev-lang/php[gmp] dev-lang/php[bcmath] )
	dev-lang/php[curl,xml,ssl]
	net-misc/curl[ssl]"

S="${WORKDIR}/${MY_P2}"

src_install() {
	insinto "/usr/share/php/${PN}"
	cd "${S}/Auth" && doins -r .

	use examples && dodoc -r ../examples
}

pkg_postinst() {
	elog "This ebuild can optionally make use of:"
	elog "    dev-php/PEAR-DB"
}
