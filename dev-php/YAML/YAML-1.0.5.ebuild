# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/YAML/YAML-1.0.5.ebuild,v 1.2 2014/08/10 20:58:43 slyfox Exp $

EAPI=3

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.symfony-project.com"
PHP_PEAR_PN="YAML"

inherit php-pear-lib-r1

DESCRIPTION="The Symfony YAML Component"
HOMEPAGE="http://symfony-project.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
