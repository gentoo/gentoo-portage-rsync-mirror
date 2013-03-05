# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xhprof/xhprof-0.9.2.ebuild,v 1.3 2013/03/05 10:09:34 olemarkus Exp $

EAPI="5"

PHP_EXT_S="${WORKDIR}/${P}/extension"
inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

HOMEPAGE="http://pecl.php.net/package/xhprof"
DESCRIPTION="A Hierarchical Profiler for PHP"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		dev-lang/php
		"
