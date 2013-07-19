# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-rrd/pecl-rrd-1.1.0.ebuild,v 1.1 2013/07/19 14:13:06 olemarkus Exp $

EAPI=5

USE_PHP="php5-4 php5-5"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="RRDtool bindings for PHP"
LICENSE="BSD"

SLOT="0"
IUSE=""

DEPEND=">=net-analyzer/rrdtool-1.4.5-r1"
RDEPEND="${DEPEND}"
