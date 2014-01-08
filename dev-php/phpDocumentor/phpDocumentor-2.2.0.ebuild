# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpDocumentor/phpDocumentor-2.2.0.ebuild,v 1.1 2014/01/08 15:42:38 mabi Exp $

EAPI=5

PHP_PEAR_URI="pear.phpdoc.org"

inherit php-pear-r1

DESCRIPTION="The phpDocumentor package provides automatic documenting of php api directly from the source."

LICENSE="MIT"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# block old version that provides the same binary
DEPEND="media-gfx/graphviz
	!dev-php/PEAR-PhpDocumentor"

src_install() {
	php-pear-r1_src_install

	# install manual, tutorial, reference material
	use doc && dodoc -r docs/*
}
