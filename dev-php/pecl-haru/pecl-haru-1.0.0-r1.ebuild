# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-haru/pecl-haru-1.0.0-r1.ebuild,v 1.1 2011/12/14 22:37:15 mabi Exp $

EAPI=3

PHP_EXT_NAME="haru"

inherit php-ext-pecl-r2

DESCRIPTION="An interface to libharu, a PDF generator"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="png zlib"

DEPEND="media-libs/libharu[png?,zlib?]"
RDEPEND="${DEPEND}"

src_configure() {
	# config.m4 is broken checking paths, so we need to override it
	my_conf="--with-haru=/usr"
	use png && my_conf+=" --with-png-dir=/usr"
	use zlib && my_conf+=" --with-zlib-dir=/usr"

	php-ext-source-r2_src_configure
}
