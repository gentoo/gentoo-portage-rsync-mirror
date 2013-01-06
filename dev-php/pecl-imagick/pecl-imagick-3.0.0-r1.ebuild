# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-imagick/pecl-imagick-3.0.0-r1.ebuild,v 1.1 2011/12/14 22:39:57 mabi Exp $

EAPI=3

PHP_EXT_NAME="imagick"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

inherit php-ext-pecl-r2

KEYWORDS="amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="PHP wrapper for the ImageMagick library."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="examples"

DEPEND=">=media-gfx/imagemagick-6.2.4"
RDEPEND="${DEPEND}"

MY_PV="${PV/_/}"
PECL_PKG_V="${PECL_PKG}-${MY_PV}"
FILENAME="${PECL_PKG_V}.tgz"
SRC_URI="http://pecl.php.net/get/${FILENAME}"
S="${WORKDIR}/${PECL_PKG_V}"

my_conf="--with-imagick=/usr"
