# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/YAML/YAML-1.0.5.ebuild,v 1.1 2012/03/10 14:33:53 olemarkus Exp $

EAPI=3

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.symfony-project.com"
PHP_PEAR_PN="YAML"

inherit php-pear-lib-r1

DESCRIPTION="The Symfony YAML Component."
HOMEPAGE="http://symfony-project.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
