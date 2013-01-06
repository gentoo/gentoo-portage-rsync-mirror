# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/magickwand/magickwand-1.0.8-r1.ebuild,v 1.1 2011/04/10 17:37:54 olemarkus Exp $

EAPI="2"

PHP_EXT_NAME="magickwand"
PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"
DOCS="AUTHOR ChangeLog CREDITS README TODO"

MY_PN="MagickWandForPHP"
IUSE=""

inherit php-ext-source-r2

DESCRIPTION="A native PHP-extension to the ImageMagick MagickWand API."
HOMEPAGE="http://www.magickwand.org/"
SRC_URI="http://www.magickwand.org/download/php/${MY_PN}-${PV}.tar.bz2"

LICENSE="MagickWand"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=media-gfx/imagemagick-6.5.2.9"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
