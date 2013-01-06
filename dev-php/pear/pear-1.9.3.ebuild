# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pear/pear-1.9.3.ebuild,v 1.7 2012/06/11 15:26:20 mabi Exp $

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"

DESCRIPTION="PEAR - PHP Extension and Application Repository"
HOMEPAGE="http://pear.php.net/"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="!<dev-php/PEAR-PEAR-1.8.1
	~dev-php/PEAR-PEAR-${PV}
	>=dev-php/PEAR-Archive_Tar-1.3.7
	>=dev-php/PEAR-Console_Getopt-1.2.3
	>=dev-php/PEAR-Structures_Graph-1.0.2
	>=dev-php/PEAR-XML_Util-1.2.1"
RDEPEND="${DEPEND}"

src_install() {
	:;
}

pkg_postinst() {
	pear clear-cache

	# Update PEAR/PECL channels as needed, add new ones to the list if needed
	elog "Updating PEAR/PECL channels"
	local pearchans="pear.php.net pecl.php.net components.ez.no
	pear.propelorm.org pear.phing.info	pear.symfony-project.com pear.phpunit.de
	pear.php-baustelle.de pear.phpontrax.com pear.agavi.org"

	for chan in ${pearchans} ; do
		pear channel-discover ${chan}
		pear channel-update ${chan}
	done
}
