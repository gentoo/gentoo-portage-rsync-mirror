# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-id3/pecl-id3-0.2-r2.ebuild,v 1.1 2011/09/18 11:24:09 olemarkus Exp $

EAPI=3

PHP_EXT_NAME="id3"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="EXPERIMENTAL TODO"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Read and write ID3 tags in MP3 files with PHP."
LICENSE="PHP-3"
SLOT="0"
IUSE="examples"

DEPEND=""
RDEPEND=""
